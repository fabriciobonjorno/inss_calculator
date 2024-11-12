# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name { Faker::Name.first_name }
    document { Faker::Number.number(digits: 11).to_s }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    income { "9.99" }
  end
end
