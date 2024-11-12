# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    zip_code { Faker::Address.zip_code }
    address { Faker::Address.street_address }
    address_number { Faker::Address.building_number }
    complement { Faker::Address.secondary_address }
    state { Faker::Address.state }
    city { Faker::Address.city }
    neighborhood { Faker::Address.community }
    addressable { create(:proponent) }
  end
end
