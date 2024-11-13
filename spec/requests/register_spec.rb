# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegisterController, type: :controller do
  describe "GET #new" do
    it "assigns a new proponent to the @proponent variable" do
      get :new
      expect(assigns(:proponent)).to be_a_new(Proponent)
    end

    it "builds an address associated with the proponent" do
      get :new
      expect(assigns(:proponent).address).to be_a_new(Address)
    end

    it "builds at least one phone associated with the proponent" do
      get :new
      expect(assigns(:proponent).phones.size).to eq(1)
      expect(assigns(:proponent).phones.first).to be_a_new(Phone)
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          proponent: {
            name: "John Doe",
            document:  Faker::IdNumber.brazilian_citizen_number(formatted: true),
            birth_date: "1990-01-01",
            income: "5000.0",
            address_attributes: {
              zip_code: "12345-678",
              street: "Main Street",
              street_number: "123",
              complement: "Apartment 101",
              neighborhood: "Downtown",
              city: "Metropolis",
              state: "NY"
            },
            phones_attributes: [
              { kind: "mobile", number: "+1 555 555 5555" }
            ]
          }
        }
      end

      it "creates a new proponent with its associations" do
        expect {
          post :create, params: valid_params
        }.to change(Proponent, :count).by(1)
        .and change(Address, :count).by(1)
        .and change(Phone, :count).by(1)
      end

      it "redirects to the registration path" do
        post :create, params: valid_params
        expect(response).to redirect_to(register_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          proponent: {
            name: "",
            document: "",
            birth_date: "",
            income: "",
            address_attributes: {
              zip_code: "",
              street: "",
              street_number: "",
              neighborhood: "",
              city: "",
              state: ""
            },
            phones_attributes: [
              { kind: "mobile", number: "" }
            ]
          }
        }
      end

      it "does not create a new proponent" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Proponent, :count)
      end

      it "renders the :new template with unprocessable_entity status" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end
end
