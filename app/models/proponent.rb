# frozen_string_literal: true

class Proponent < ApplicationRecord
  validates :name, :document, :birth_date, :income, presence: true
  validates :document, uniqueness: true
  has_one :address, as: :addressable, dependent: :destroy
  has_many :phones, as: :phoneble, dependent: :destroy
end
