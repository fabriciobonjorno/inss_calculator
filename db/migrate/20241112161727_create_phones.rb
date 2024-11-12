# frozen_string_literal: true

class CreatePhones < ActiveRecord::Migration[7.2]
  def change
    create_table :phones do |t|
      t.integer :kind
      t.string :number
      t.references :phoneble, polymorphic: true, null: false

      t.timestamps
    end
  end
end
