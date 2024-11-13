# frozen_string_literal: true

require "csv"
class ExportProponentsJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = DashUser.find(user_id)
    proponents = Proponent.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << [ "ID", "Name", "Documento", "Salário", "Valor Inss" ]
      proponents.each do |proponent|
        csv << [ proponent.id, proponent.name, proponent.document, proponent.income, proponent.inss_value ]
      end
    end

    ReportMailer.send_csv(user, csv_data).deliver_later
  end
end
