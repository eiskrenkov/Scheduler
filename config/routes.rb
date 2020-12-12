# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  telegram_webhook Telegram::PersonalController

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :admin do
    resources :settings, only: %i[index] do
      put :update, on: :collection
      post :update_v_bsu_settings, on: :collection
    end

    resources :weekdays do
      resources :pairs, only: %i[destroy]
    end
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

  namespace :api do
    resources :pairs, only: [] do
      collection do
        get :current
        get :weekday
      end
    end
  end

  post 'set_theme' => 'common#set_theme'

  root to: 'common#index'
end
# rubocop:enable Metrics/BlockLength
