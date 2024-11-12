# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    kind { rand(0..1) }
    number { Faker::PhoneNumber.phone_number_with_country_code }
    phoneble { create(:proponent) }
  end
end
