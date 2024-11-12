# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:income) }
    it { should validate_uniqueness_of(:document) }
  end

  describe 'associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:phones).dependent(:destroy) }
  end

  describe 'address association' do
    it 'associates an address with a proponent' do
      proponent = create(:proponent)
      address = create(:address, addressable: proponent)

      expect(proponent.address).to eq(address)
      expect(address.addressable).to eq(proponent)
    end
  end
end
