class CreateBasicUserObject < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :token
      t.string :handle

      t.index :email, unique: true
      t.index :token, unique: true
      t.index :handle, unique: true

      t.timestamps
    end
  end
end
