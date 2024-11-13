# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let(:dash_user) { create(:dash_user) }

  before do
    sign_in dash_user
  end

  describe "GET /index" do
    it "returns http success" do
      get "/dashboard"
      expect(response).to have_http_status(:success)
    end
  end
end
