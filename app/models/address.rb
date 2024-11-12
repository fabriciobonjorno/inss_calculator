# frozen_string_literal: true

class Address < ApplicationRecord
  validates :zip_code, :address, :address_number, presence: true
  validates :city, :neighborhood, :state, presence: true

  belongs_to :addressable, polymorphic: true
end
