class AddDescriptionToSf311Cases < ActiveRecord::Migration[5.2]
  def change
    add_column :sf311_cases, :description, :string
  end
end
