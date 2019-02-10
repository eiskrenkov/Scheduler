Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  devise_for :users

  resources :weekdays

  namespace :api do
    get :current
    get :weekday
  end

  root to: "admin#home"
end
