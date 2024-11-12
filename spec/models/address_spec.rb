# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:street_number) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:neighborhood) }
  end

  describe 'associations' do
    it { should belong_to(:addressable) }
  end
end
