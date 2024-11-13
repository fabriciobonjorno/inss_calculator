# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_dash_user!
  def index
    @proponents = Proponent.all.page(params[:page]).per(5)
  end

  def generate_csv
    ExportProponentsJob.perform_later(current_dash_user.id)
    redirect_to dashboard_path, notice: "O relatório está sendo gerado e estará disponível em breve."
  end
end
