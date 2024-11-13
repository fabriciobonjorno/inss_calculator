# frozen_string_literal: true

class Proponent < ApplicationRecord
  before_validation :clean_document

  validates :name, :document, :birth_date, :income, presence: true
  validates :document, uniqueness: true
  validate :validate_document

  has_one :address, as: :addressable, dependent: :destroy
  has_many :phones, as: :phoneble, dependent: :destroy

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :phones

  private

  def clean_document
    self.document = document.gsub(/[^\d]/, "") if document.present?
  end

  def validate_document
    errors.add :document, "precisa ser um CPF Válido" unless CPF.valid?(document)
  end
end
