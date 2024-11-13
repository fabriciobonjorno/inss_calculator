# frozen_string_literal: true

FactoryBot.define do
  factory :dash_user do
    email { "teste@teste.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end
