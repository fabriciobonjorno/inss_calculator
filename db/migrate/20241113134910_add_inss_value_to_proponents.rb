# frozen_string_literal: true

class AddInssValueToProponents < ActiveRecord::Migration[7.2]
  def change
    unless column_exists?(:proponents, :inss_value)
      add_column :proponents, :inss_value, :decimal, precision: 10, scale: 2
    end
    add_index :proponents, :inss_value
  end
end
