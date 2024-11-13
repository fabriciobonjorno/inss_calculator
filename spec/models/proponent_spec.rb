# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:birth_date) }
    it { should validate_presence_of(:income) }

    it "validates uniqueness of document" do
      proponent1 = create(:proponent, document: "155.356.390-52")

       proponent2 = build(:proponent, document: "155.356.390-52")
      expect(proponent2.valid?).to be_falsey
      expect(proponent2.errors[:document]).to include("has already been taken")
    end
  end

  describe 'associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:phones).dependent(:destroy) }
  end

  describe 'nested attributes' do
    let(:proponent) { create(:proponent) }

    context 'address' do
      it 'allows nested attributes for address' do
        attributes = {
          address_attributes: {
            zip_code: '12345-678',
            street: 'Main Street',
            street_number: '123',
            complement: 'Apartment 101',
            neighborhood: 'Downtown',
            city: 'Metropolis',
            state: 'NY'
          }
        }

        proponent.update(attributes)
        expect(proponent.address).to have_attributes(
          zip_code: '12345-678',
          street: 'Main Street',
          street_number: '123',
          complement: 'Apartment 101',
          neighborhood: 'Downtown',
          city: 'Metropolis',
          state: 'NY'
        )
      end
    end

    context 'phones' do
      it 'allows nested attributes for phones' do
        attributes = {
          phones_attributes: [
            { kind: 'mobile', number: '+1 555 555 5555' },
            { kind: 'commercial', number: '+1 555 555 5556' }
          ]
        }

        proponent.update(attributes)
        expect(proponent.phones.size).to eq(2)
        expect(proponent.phones.map(&:kind)).to contain_exactly('mobile', 'commercial')
        expect(proponent.phones.map(&:number)).to contain_exactly('+1 555 555 5555', '+1 555 555 5556')
      end
    end
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
