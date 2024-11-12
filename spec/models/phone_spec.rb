# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Phone, type: :model do
  describe 'validations' do
    it { should define_enum_for(:kind).with_values({ cellphone: 0, commercial: 1 }) }
    it { should validate_presence_of(:number) }
  end

  describe 'associations' do
    it { should belong_to(:phoneble) }
  end
end
