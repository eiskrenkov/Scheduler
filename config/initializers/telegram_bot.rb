# Configures Telegram Bot

Telegram.bots_config = {
  default: ENV['TELEGRAM_BOT_TOKEN'] || Rails.application.credentials.dig(:telegram_bot, :token)
}
