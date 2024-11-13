# frozen_string_literal: true

FactoryBot.define do
  factory :proponent do
    name {  Faker::Name.name }
    document { Faker::IdNumber.brazilian_citizen_number(formatted: true) }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    income { "9.99" }
  end
end
