# Configures Telegram Bot

Telegram.bots_config = {
  default: Rails.application.credentials.telegram_bot[:token]
}
