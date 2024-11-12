# frozen_string_literal: true

class CreateProponents < ActiveRecord::Migration[7.2]
  def change
    return if table_exists? "proponents"
    create_table :proponents do |t|
      t.string :name, index: true
      t.string :document, index: { unique: true }
      t.date :birth_date, index: true
      t.decimal :income, precision: 10, scale: 2, index: true

      t.timestamps
    end
  end
end
