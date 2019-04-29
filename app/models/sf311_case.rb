# == Schema Information
#
# Table name: sf311_cases
#
#  id                              :bigint(8)        not null, primary key
#  address                         :string
#  agency_responsible              :string
#  closed_date                     :datetime
#  description                     :string
#  lat                             :float
#  long                            :float
#  media_url                       :string
#  media_url_description           :string
#  neighborhoods_sffind_boundaries :string
#  point                           :geography({:srid point, 4326
#  point_address                   :string
#  point_city                      :string
#  point_state                     :string
#  point_zip                       :string
#  police_district                 :string
#  requested_datetime              :datetime
#  service_details                 :string
#  service_name                    :string
#  service_subtype                 :string
#  source                          :string
#  status_description              :string
#  status_notes                    :string
#  street                          :string
#  supervisor_district             :integer
#  updated_datetime                :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  service_request_id              :integer
#
# Indexes
#
#  index_sf311_cases_on_requested_datetime  (requested_datetime)
#  index_sf311_cases_on_service_request_id  (service_request_id) UNIQUE
#

require 'csv'

class Sf311Case < ApplicationRecord
  has_one :sf311_case_metadatum, dependent: :destroy

  validates :service_request_id, uniqueness: true

  before_create :add_description
  after_create :add_metadata

  SERVICE_SUBTYPES = {
    blocked_bike_lane: 'Blocking_Bicycle_Lane'
  }

  def add_metadata
    Sf311CaseMetadatum.update_metadata(self)
  end

  def add_description
    data = Net::HTTP.get(URI("http://mobile311.sfgov.org/open311/v2/requests/#{service_request_id}.json"))
    json = JSON.parse(data)
    self.description = json[0]['description']
  end

  class << self
    def ingest_csv_case_data!(case_data_csv)
      # TODO: Figure out a more efficient way to import case records. Currently,
      # each record takes 2 SQL statements to create (1 for the record itself,
      # one for the case metadata record)
      num_imported_cases = 0

      CSV.parse(case_data_csv, headers: true) do |row|
        Sf311Case.create!(row.to_h)
        num_imported_cases += 1

        # Sleep for a second to limit the number of requests made by the Sf311Case#add_description callback:
        sleep(1)
      end

      num_imported_cases
    end
  end
end
