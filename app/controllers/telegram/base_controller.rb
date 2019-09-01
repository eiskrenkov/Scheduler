class Telegram::BaseController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Controllers::Telegram::UserSupport

  use_session!

  def start!(*)
    send_message t('telegram.base.start', username: username)
  end

  def help!(*)
    send_message t('telegram.base.help')
  end

  def ping!(*)
    send_message 'pong'
  end

  private

  def send_message(text)
    respond_with :message, text: text
  end

  def username
    telegram_user.first_name || telegram_user.username
  end
end
