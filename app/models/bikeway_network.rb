# == Schema Information
#
# Table name: bikeway_networks
#
#  id         :integer          not null, primary key
#  barrier    :string(254)
#  biap       :string(254)
#  buffered   :string(254)
#  cnn        :decimal(, )
#  contraflow :string(254)
#  created_us :string(254)
#  date_creat :date
#  date_last_ :date
#  dir        :string(254)
#  direct     :string(254)
#  double     :decimal(, )
#  facility_t :string(254)
#  from_st    :string(254)
#  fy         :decimal(, )
#  geom       :geometry({:srid= multilinestring, 4326
#  globalid   :string(254)
#  greenwave  :string(254)
#  install_mo :decimal(, )
#  install_yr :decimal(, )
#  last_edite :string(254)
#  length     :decimal(, )
#  notes      :string(254)
#  number     :string(254)
#  objectid   :decimal(, )
#  qtr        :decimal(, )
#  raised     :string(254)
#  shape_len  :decimal(, )
#  sharrow    :decimal(, )
#  sm_sweeper :string(254)
#  street     :string(254)
#  streetname :string(254)
#  surface_tr :string(254)
#  symbology  :string(254)
#  time_creat :string(254)
#  time_last_ :string(254)
#  to_st      :string(254)
#  update_mo  :decimal(, )
#  update_yr  :decimal(, )
#

class BikewayNetwork < ApplicationRecord
  has_many :sf311_case_metadatum

  def self.nearest(lat, long, max_distance)
    max_distance ||= 50
    BikewayNetwork
      .select("*, st_DistanceSphere(geom, ST_MakePoint(#{long}, #{lat})) as dist")
      .where("st_DistanceSphere(geom, ST_MakePoint(?, ?)) <= #{max_distance}", long, lat)
      .order('dist')
      .limit(1)
  end
end
