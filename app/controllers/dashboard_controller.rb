# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_dash_user!
  def index
    graphic
    @proponents = Proponent.all.page(params[:page]).per(5)
  end


  def graphic
    @ranges = [
      { name: "Até R$ 1.045,00", limit: 0..1045.00 },
      { name: "De R$ 1.045,01 a R$ 2.089,60", limit: 1045.01..2089.60 },
      { name: "De R$ 2.089,61 até R$ 3.134,40", limit: 2089.61..3134.40 },
      { name: "De R$ 3.134,41 até R$ 6.101,06", limit: 3134.41..6101.06 }
    ]

    @income_ranges = @ranges.map do |range|
      {
        name: range[:name],
        count: Proponent.where(income: range[:limit]).count
      }
    end

    @chart_data = {
      labels: @income_ranges.map { |range| range[:name] },
      datasets: [ {
        label: "Contagem de Proponentes",
        backgroundColor: "rgba(59, 130, 246, 0.2)",
        borderColor: "#3B82F6",
        borderWidth: 1,
        data: @income_ranges.map { |range| range[:count] }
      } ]
    }

    @chart_options = {
      responsive: true,
      maintainAspectRatio: false,
      aspectRatio: 1,
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  end

  def generate_csv
    ExportProponentsJob.perform_later(current_dash_user.id)
    redirect_to dashboard_path, notice: "O relatório está sendo gerado e estará disponível em breve."
  end
end
