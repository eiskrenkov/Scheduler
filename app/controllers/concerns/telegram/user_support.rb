module Telegram::UserSupport
  extend ActiveSupport::Concern

  included do
    rescue_from Exceptions::UserDoesNotExist do
      send_message t('telegram.errors.user_does_not_exist')
    end
  end

  def current_user
    @current_user ||= User.find_by(telegram_id: from['id'])
  end

  private

  def check_user_existence
    raise Exceptions::UserDoesNotExist unless current_user
  end
end
