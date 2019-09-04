Rails.application.routes.draw do
  telegram_webhook Telegram::ScheduleController

  devise_for :web_users

  namespace :admin do
    resources :weekdays do
      resources :pairs, only: %i[destroy]
    end
  end

  namespace :dashboard do
    resources :today, only: :index
    resources :schedule, only: :index

    post 'set_group' => 'schedule#set_group'
    post 'set_theme' => 'schedule#set_theme'

    root to: 'today#index'
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
