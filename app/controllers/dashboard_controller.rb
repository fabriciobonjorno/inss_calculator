# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_dash_user!
  def index
  end
end
