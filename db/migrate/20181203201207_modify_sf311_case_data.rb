class ModifySf311CaseData < ActiveRecord::Migration[5.2]
  def change
    rename_column :bikeway_networks, :gid, :id
    add_reference :sf311_case_metadata, :bikeway_network, foreign_key: true
    remove_column :sf311_case_metadata, :bike_lane_type, :string    
  end
end
