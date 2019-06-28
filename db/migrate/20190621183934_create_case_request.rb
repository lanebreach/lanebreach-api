# frozen_string_literal: true

class CreateCaseRequest < ActiveRecord::Migration[5.2]
  def change
    create_table :case_requests do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.jsonb :meta

      t.timestamps
    end
  end
end
