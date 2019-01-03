class RemoveMobileMetadata < ActiveRecord::Migration[5.2]
  def change
    drop_table :mobile_metadata
  end
end
