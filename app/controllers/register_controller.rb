# frozen_string_literal: true

class RegisterController < ApplicationController
  def new
    @proponent = Proponent.new
    @address = @proponent.build_address
    @phone = @proponent.phones.build
  end
end
