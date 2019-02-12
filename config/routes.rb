Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  devise_for :users

  resources :weekdays do
    resources :pairs, :only => [:destroy]
  end

  namespace :api do
    get :current
    get :weekday
  end

  root to: "admin#home"
end
