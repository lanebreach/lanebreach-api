class AddRequestedTimestampIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :sf311_cases, :requested_datetime
  end
end
