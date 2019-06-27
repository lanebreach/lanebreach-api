class CreateSfDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :sf_districts do |t|
    	t.string :district_name
    	t.string :supervisor_name
    	t.geometry :geom
    end

    # Seed the SF districts table:
    ActiveRecord::Base.connection.execute(IO.read(Rails.root.join('db', 'sql-files', 'sf_districts.sql')))
  end
end
