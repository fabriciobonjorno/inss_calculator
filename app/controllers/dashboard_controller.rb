# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_dash_user!
  def index
    @proponents = Proponent.all.page(params[:page]).per(5)
  end
end
