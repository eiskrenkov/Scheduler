Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  # Web pages routes
  scope module: :web do
    namespace :public do
      resources :schedule, only: :index
    end

    namespace :personal do
      resources :today, only: :index
      resources :schedule, only: :index

      resources :weekdays, only: %i[edit update]

      post :set_group, to: 'schedule#set_group'
      get :profile, to: 'user#show'
      patch :update_profile, to: 'user#update'

      root to: 'today#index'
    end

    namespace :admin do
      resources :application_settings, only: %i[index] do
        put :update, on: :collection
      end

      resources :applications, except: %i[show]

      resources :v_bsu_settings, only: %i[index] do
        put :update, on: :collection
        post :update_remote, on: :collection
      end

      resources :groups do
        resources :weekdays, only: %i[index edit update]
      end

      root to: 'application_settings#index'
    end

    resources :theme, only: [] do
      post :switch, on: :collection
    end
  end

  # API routes
  namespace :api do
    get :init, to: 'init#index'

    resources :schedule, only: %i[index]

    namespace :groups do
      get :schedule
    end

    namespace :telegram do
      scope module: :base do
        get :schedule
      end

      namespace :groups do
        get :list
        post :set
      end
    end
  end

  # Telegram routes
  telegram_webhook Telegram::PersonalController

  root to: 'web/public/schedule#index'
end
