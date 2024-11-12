# frozen_string_literal: true

class Proponent < ApplicationRecord
  validates :name, :document, :birth_date, :income, presence: true
end
