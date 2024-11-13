# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegisterController, type: :controller do
  describe "GET #new" do
    it "atribui um novo proponente à variável @proponent" do
      get :new
      expect(assigns(:proponent)).to be_a_new(Proponent)
    end

    it "constrói um endereço associado ao proponente" do
      get :new
      expect(assigns(:proponent).address).to be_a_new(Address)
    end

    it "constrói pelo menos um telefone associado ao proponente" do
      get :new
      expect(assigns(:proponent).phones.size).to eq(1)
      expect(assigns(:proponent).phones.first).to be_a_new(Phone)
    end

    it "renderiza o template :new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "com parâmetros válidos" do
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

      it "cria um novo proponente com suas associações" do
        expect {
          post :create, params: valid_params
        }.to change(Proponent, :count).by(1)
        .and change(Address, :count).by(1)
        .and change(Phone, :count).by(1)
      end

      it "redireciona para o caminho de registro" do
        post :create, params: valid_params
        expect(response).to redirect_to(register_path)
      end
    end

    context "com parâmetros inválidos" do
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

      it "não cria um novo proponente" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Proponent, :count)
      end

      it "renderiza o template :new com status unprocessable_entity" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end
end
