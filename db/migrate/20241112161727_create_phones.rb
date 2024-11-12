# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[7.2]
  def change
    return if table_exists? "phones"
    create_table :phones do |t|
      t.integer :kind, index: true
      t.string :number, index: true
      t.references :phoneble, polymorphic: true, null: false

      t.timestamps
    end
  end
end
