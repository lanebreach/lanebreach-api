# == Schema Information
#
# Table name: sf_mta_ridership_counts
#
#  id                       :bigint(8)        not null, primary key
#  counter_location         :string
#  days                     :string
#  hour_of_collection_time  :integer
#  month_of_collection_time :string
#  total_bike_count         :integer
#  year_of_collection_time  :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class SfMtaRidershipCount < ApplicationRecord

end
