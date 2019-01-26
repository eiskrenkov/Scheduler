Rails.application.routes.draw do
  telegram_webhook TelegramWebhooksController

  devise_for :users

  root to: "admin#home"
end
