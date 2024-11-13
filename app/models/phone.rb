# frozen_string_literal: true

class Phone < ApplicationRecord
  validates :number, presence: true

  enum kind: %i[commercial mobile]

  belongs_to :phoneble, polymorphic: true
end
