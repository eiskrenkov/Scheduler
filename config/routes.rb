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

      resources :weekdays do
        resources :pairs, only: %i[destroy]
      end

      post :set_group, to: 'schedule#set_group'
      get :profile, to: 'user#show'
      patch :update_profile, to: 'user#update'

      root to: 'today#index'
    end

    namespace :admin do
      resources :settings, only: %i[index] do
        put :update, on: :collection
        post :update_v_bsu_settings, on: :collection
      end

      resources :groups do
        resources :weekdays, only: %i[index edit update] do
          resources :pairs, only: %i[destroy]
        end
      end

      root to: 'settings#index'
    end

    resources :theme, only: [] do
      post :switch, on: :collection
    end
  end

  # API routes
  namespace :api do
    resources :pairs, only: [] do
      collection do
        get :current
        get :weekday
      end
    end
  end

  # Telegram routes
  telegram_webhook Telegram::PersonalController

  root to: 'web/public/schedule#index'
end
