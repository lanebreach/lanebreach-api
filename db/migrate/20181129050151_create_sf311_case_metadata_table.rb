class CreateSf311CaseMetadataTable < ActiveRecord::Migration[5.2]
  def change
    create_table :sf311_case_metadata do |t|      
      t.references :sf311_case, foreign_key: true
      t.string :bike_lane_type
      t.timestamps
    end
  end
end
