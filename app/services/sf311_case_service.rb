# frozen_string_literal: true

require 'soda/client'

module Sf311CaseService
  extend self

  SODA_CREDENTIALS = {
    domain: 'data.sfgov.org',
    app_token: 'QPCu2zzyc3jV5UkGfpOrGnXi7'
  }

  CASE_DATASET_ID = 'ktji-gk7t'

  # https://dev.socrata.com/docs/datatypes/floating_timestamp.html
  SODA_FLOATING_TIMESTAMP_FORMAT = '%Y-%m-%dT%T'

  def get_blocked_bike_lane_case_data(options = {})
    # TODO: Add a comment explaining why this limit was chosen
    options[:limit] ||= 5000

    get_cases(
      Sf311Case::SERVICE_SUBTYPES[:blocked_bike_lane],
      options
    )
  end

  def create_case(case_attributes)
    if Rails.env.production?
      # TODO: Ensure this call behaves as expected
      client.post(CASE_DATASET_ID, [case_attributes])
    else
      Rails.logger.info("#{self.name}##{__method__} called successfully, actual case creation disabled in this environment (#{Rails.env})")
    end
  end

  private

  def client
    @client ||= SODA::Client.new(SODA_CREDENTIALS)
  end

  def get_cases(subtype, from_datetime: nil, to_datetime: nil, offset: 0, limit: 10, format: :json)
    request_params = {
      service_subtype: subtype,
      '$offset': offset,
      '$limit': limit
    }

    query_conditions = []

    if from_datetime
      from_ts = from_datetime.strftime(SODA_FLOATING_TIMESTAMP_FORMAT)
      query_conditions << "requested_datetime >= '#{from_ts}'"
    end

    if to_datetime
      to_ts = to_datetime.strftime(SODA_FLOATING_TIMESTAMP_FORMAT)
      query_conditions << "requested_datetime <= '#{to_ts}'"
    end

    request_params['$where'] = query_conditions.join(' and ') if query_conditions

    client.get("#{CASE_DATASET_ID}.#{format}", request_params)
  end

end
