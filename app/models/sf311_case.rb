# == Schema Information
#
# Table name: sf311_cases
#
#  id                              :bigint(8)        not null, primary key
#  address                         :string
#  agency_responsible              :string
#  closed_date                     :datetime
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

  after_create :add_metadata

  SERVICE_SUBTYPES = {
    blocked_bike_lane: 'Blocking_Bicycle_Lane'
  }

  scope :bike_lane_blockage, -> { where(service_subtype: SERVICE_SUBTYPES[:blocked_bike_lane]) }

  def add_metadata
    Sf311CaseMetadatum.update_metadata(self)
  end

  class << self

    def ingest_csv_case_data!(case_data_csv)
      # TODO: Figure out a more efficient way to import case records. Currently,
      # each record takes 2 SQL statements to create (1 for the record itself,
      # one for the case metadata record)
      CSV.parse(case_data_csv, headers: true) do |row|
        Sf311Case.create!(row.to_h)
      end
    end

  end

end
