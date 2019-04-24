# Currently, the SF MTA hourly counts report only includes data through 2017 (see
# https://www.sfmta.com/reports/hourly-bike-counts-dashboard for details). This worker
# simply ingests the most recent counts file and should be modified to periodically
# ingest new records once more up-to-date information is available.
require 'csv'

class IngestSfMtaHourlyRidershipCountsWorker
  include Sidekiq::Worker

  BULK_IMPORT_RECORD_COUNT = 1000
  DOWNLOAD_TIMEOUT_IN_MINS = 5.minutes

  RIDERSHIP_COUNTS_FILE_URL = 'https://stats.sfmta.com/t/public/views/AutomatedBicycleCounters/HOURLYTABLE.csv'

  def perform
    hourly_counts_file = download_hourly_counts_file

    storage_time = Benchmark.realtime do
      CSV.foreach(hourly_counts_file.path, headers: true, header_converters: :symbol).
          each_slice(BULK_IMPORT_RECORD_COUNT) do |ridership_table_fragment|
        ridership_counts = ridership_table_fragment.map { |row| row.to_h }
        SfMtaRidershipCount.import!(ridership_counts)
      end
    end

    Rails.logger.info("Stored the contents of the hourly counts file in #{storage_time} seconds")
  ensure
    hourly_counts_file&.delete
  end

  def download_hourly_counts_file
    uri = URI(RIDERSHIP_COUNTS_FILE_URL)

    http_client = Net::HTTP.new(uri.host, uri.port)

    # TODO: Usually not a good idea to skip SSL certification; find a way around this
    http_client.verify_mode = OpenSSL::SSL::VERIFY_NONE

    http_client.use_ssl = true
    http_client.read_timeout = DOWNLOAD_TIMEOUT_IN_MINS

    # This file is upwards of 10 MB and takes over a minute to download; store it on disk
    # to reduce memory consumption and lessen the chances of a timeout:
    hourly_counts_file = Tempfile.new('hourly_counts_table.csv')

    request = Net::HTTP::Get.new(uri.request_uri)

    file_download_time = Benchmark.realtime do
      http_client.request(request) do |response|
        response.read_body do |chunk|
          hourly_counts_file.write(chunk)
        end
      end
    end

    hourly_counts_file.flush

    Rails.logger.info("Downloaded the hourly counts file in #{file_download_time} seconds")

    hourly_counts_file
  end
end
