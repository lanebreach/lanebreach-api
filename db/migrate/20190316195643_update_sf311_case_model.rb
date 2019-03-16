class UpdateSf311CaseModel < ActiveRecord::Migration[5.2]
  def change
    add_column :sf311_cases, :street, :string
  end
end
