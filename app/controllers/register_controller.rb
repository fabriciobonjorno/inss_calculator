# frozen_string_literal: true

class RegisterController < ApplicationController
  def new
    @proponent = Proponent.new
    @proponent.build_address unless @proponent.address
    @proponent.phones.build unless @proponent.phones.any?
  end

  def create
    params["proponent"]["income"] = clean_income(params["proponent"]["income"])
    @proponent = Proponent.new(proponent_params)
    @proponent.build_address unless @proponent.address
    @proponent.phones.build unless @proponent.phones.any?
    if @proponent.save
      redirect_to register_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def calculate_inss
    income = params[:income].to_f
    if income <= 0
      render turbo_stream: turbo_stream.replace(
        "inss_value",
        partial: "inss_value", locals: { inss_value: 0 }
      )
    else
      inss_value = calculate_inss_value(income)
      render turbo_stream: turbo_stream.replace(
        "inss_value",
        partial: "inss_value", locals: { inss_value: inss_value }
      )
    end
  end

  def get_address
    zip_code = params[:zip_code]
    connection = Faraday.new(url: "https://viacep.com.br/ws/")
    response = connection.get("#{zip_code}/json/")
    json = response.body

    render json:, status: :ok
  end

  private

  def calculate_inss_value(income)
    brackets = [
      { max: 1_045.00, rate: 0.075 },
      { max: 2_089.60, rate: 0.09 },
      { max: 3_134.40, rate: 0.12 },
      { max: 6_101.06, rate: 0.14 }
    ]

    inss = 0
    brackets.each_with_index do |bracket, index|
      previous_max = index.zero? ? 0 : brackets[index - 1][:max]
      if income > previous_max
        taxable_income = [ income, bracket[:max] ].min - previous_max
        inss += taxable_income * bracket[:rate]
      end
    end

    inss
  end

  def proponent_params
    params.require(:proponent).permit(
      :name, :document, :birth_date, :income,
      address_attributes: [ :zip_code, :street, :street_number, :complement, :neighborhood, :city, :state ],
      phones_attributes: [ :kind, :number ]
    )
  end
end
