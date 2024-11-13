# frozen_string_literal: true

class CalculateInss
  def initialize(income)
    @income = income
  end

  def call
    calculate_inss_amount
  end

  private

  def calculate_inss_amount
    brackets = [
      { max: 1_045.00, rate: 0.075 },
      { max: 2_089.60, rate: 0.09 },
      { max: 3_134.40, rate: 0.12 },
      { max: 6_101.06, rate: 0.14 }
    ]

    inss = 0
    brackets.each_with_index do |bracket, index|
      previous_max = index.zero? ? 0 : brackets[index - 1][:max]
      if  @income > previous_max
        taxable_income = [ @income, bracket[:max] ].min - previous_max
        inss += taxable_income * bracket[:rate]
      end
    end
    inss
  end
end
