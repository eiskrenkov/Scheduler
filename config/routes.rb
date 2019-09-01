Rails.application.routes.draw do
  telegram_webhook Telegram::ScheduleController

  devise_for :web_users

  namespace :admin do
    resources :weekdays do
      resources :pairs, only: %i[destroy]
    end
  end

  namespace :dashboard do
    post 'set_group' => 'schedule#set_group'

    root to: 'schedule#index'
  end

  namespace :api do
    resources :pairs, only: [] do
      collection do
        get :current
        get :weekday
      end
    end
  end

  root to: redirect('/dashboard')
end
