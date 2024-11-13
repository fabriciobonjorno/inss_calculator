# frozen_string_literal: true

FactoryBot.define do
  factory :phone do
    kind { [ 'commercial', 'mobile' ].sample }
    number { Faker::PhoneNumber.phone_number_with_country_code }
  end
end
