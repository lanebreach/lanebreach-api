class AddServiceRequestIdIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :sf311_cases, :service_request_id, unique: true
  end
end
