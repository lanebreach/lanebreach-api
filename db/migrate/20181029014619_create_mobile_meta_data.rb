class CreateMobileMetaData < ActiveRecord::Migration[5.2]
  def change
    create_table :mobile_metadata do |t|
      t.string :environment
      t.string :category
      t.string :token
      t.string :request_id
      t.timestamps
    end
  end
end
