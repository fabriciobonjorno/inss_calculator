# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
if Proponent.count >= 10
  puts "Já existem 10 proponentes cadastrados. Interrompendo execução do seed."
else
  10.times do |i|
    name = Faker::Name.name
    document = Faker::IdNumber.brazilian_citizen_number(formatted: true)
    birth_date = Faker::Date.birthday(min_age: 18, max_age: 65)
    income = 2000 + (i * 500)
    inss_value = CalculateInss.new(income).call

    proponent = Proponent.new(
      name: name,
      document: document,
      birth_date: birth_date,
      income: income,
      inss_value: inss_value
    )

    proponent.build_address(
      zip_code: Faker::Address.zip_code,
      street: Faker::Address.street_name,
      street_number: Faker::Address.building_number,
      complement: Faker::Address.secondary_address,
      neighborhood: Faker::Address.community,
      city: Faker::Address.city,
      state: Faker::Address.state
    )

    proponent.phones.build(
      kind: i.even? ? :commercial : :mobile,
      number: Faker::PhoneNumber.phone_number_with_country_code
    )

    if proponent.save
      puts "Proponente #{i + 1} cadastrado com sucesso!"
    else
      puts "Erro ao cadastrar o proponente #{i + 1}: #{proponent.errors.full_messages.join(', ')}"
    end
  end
end
