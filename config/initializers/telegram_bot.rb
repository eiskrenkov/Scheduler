# Configures Telegram Bot

Telegram.bots_config = {
  default: Rails.application.credentials.dig(:telegram_bot, :token)
}
