# frozen_string_literal: true

require "sidekiq/web"
Rails.application.routes.draw do
  devise_for :dash_users, skip: %i[confirmations registrations unlocks]
  root "register#new"
  get "/calculate_inss", to: "register#calculate_inss"
  get "/get_address/:zip_code", to: "register#get_address"
  post "/register", to: "register#create"
  get "/dashboard", to: "dashboard#index"
  post "/generate_csv", to: "dashboard#generate_csv"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
 mount Sidekiq::Web => "/sidekiq"
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
