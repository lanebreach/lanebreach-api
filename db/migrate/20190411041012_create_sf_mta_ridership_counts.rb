class CreateSfMtaRidershipCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :sf_mta_ridership_counts do |t|
      t.string :counter_location
      t.string :days
      t.integer :hour_of_collection_time
      t.string :month_of_collection_time
      t.integer :year_of_collection_time
      t.integer :total_bike_count

      t.timestamps
    end
  end
end
