Rails.application.routes.draw do
  require "sidekiq/web"

  mount Sidekiq::Web => "/sidekiq"

  get  "reservations/:id",                  to: "reservations#show"
  post "reservations",                      to: "reservations#create"
  post "reservations/:id/payment_callback", to: "reservations#payment_callback"
end
