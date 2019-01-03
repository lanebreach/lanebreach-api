# == Schema Information
#
# Table name: sf311_case_metadata
#
#  id                 :bigint(8)        not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  bikeway_network_id :bigint(8)
#  sf311_case_id      :bigint(8)
#
# Indexes
#
#  index_sf311_case_metadata_on_bikeway_network_id  (bikeway_network_id)
#  index_sf311_case_metadata_on_sf311_case_id       (sf311_case_id)
#
# Foreign Keys
#
#  fk_rails_...  (bikeway_network_id => bikeway_networks.id)
#  fk_rails_...  (sf311_case_id => sf311_cases.id)
#

class Sf311CaseMetadatum < ApplicationRecord
  belongs_to :sf311_case
  belongs_to :bikeway_network

  def self.update_metadata(sf311_case)
    bikeway_network = BikewayNetwork.nearest(sf311_case.lat, sf311_case.long)
    return unless bikeway_network.present?

    if sf311_case.sf311_case_metadatum.present?
      sf311_case.sf311_case_metadatum.update!(bikeway_network: bikeway_network, sf311_case: sf311_case)
    else
      Sf311CaseMetadatum.create!(bikeway_network: bikeway_network, sf311_case: sf311_case)
    end
  end
end
