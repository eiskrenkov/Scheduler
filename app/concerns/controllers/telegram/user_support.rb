module Controllers::Telegram::UserSupport
  extend ActiveSupport::Concern

  def telegram_user
    @telegram_user ||= begin
      TelegramUser.find_or_create_by(telegram_id: from['id']) do |user|
        user.username = from['username']
        user.first_name = from['first_name']
        user.last_name = from['last_name']
      end
    end
  end
end
