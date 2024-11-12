# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.2]
  def change
    return if table_exists? "addresses"
    create_table :addresses do |t|
      t.string :zip_code, index: true
      t.string :street, index: true
      t.string :street_number, index: true
      t.string :complement, index: true
      t.string :state, index: true
      t.string :city, index: true
      t.string :neighborhood, index: true
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
