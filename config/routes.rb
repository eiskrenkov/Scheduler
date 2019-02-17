Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  devise_for :users

  resources :weekdays do
    resources :pairs, only: %i[destroy]
  end

  namespace :api do
    resources :pairs, only: [] do
      collection do
        get :current
        get :weekday
      end
    end
  end

  root to: 'admin#home'
end
