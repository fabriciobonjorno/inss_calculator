# frozen_string_literal: true

class ReportMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def send_csv(user, csv_data)
    @user = user
    attachments["proponents_#{Time.zone.now.to_i}.csv"] = { mime_type: "text/csv", content: csv_data }
    mail(to: @user.email, subject: "Relatório de Proponentes") do |format|
      format.text { render plain: "Olá #{@user.email},\n\nO relatório de proponentes está anexado." }
      format.html { render html: "<p>Olá #{@user.email},</p><p>O relatório de proponentes está anexado.</p>".html_safe }
    end
  end
end
