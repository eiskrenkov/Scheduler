class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include SchedulePresenter

  def start!(*)
    respond_with :message, text: t('telegram_webhooks.start', username: username)
  end

  def help!(*)
    respond_with :message, text: t('telegram_webhooks.help')
  end

  def tod!(*)
    respond_with :message, text: weekday_schedule_for(Time.now.wday)
  end

  def tom!(*)
    respond_with :message, text: weekday_schedule_for(Time.now.next_day.wday)
  end

  def action_missing(action, *_args)
    begin
      send("#{message}!")
    rescue NoMethodError
      respond_with :message, text: t('telegram_webhooks.action_missing', username: username)
    end
  end

  private

  def message
    update['message']['text'].downcase.gsub('/', '')
  end

  def username
    from['first_name'] || from['username']
  end
end
