class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include SchedulePresenter

  RESTRICTED_MESSAGES = %w[exit drop reload restart].freeze

  use_session!

  def start!
    respond_with :message, text: t('telegram_webhooks.start', username: username)
  end

  def help!
    respond_with :message, text: t('telegram_webhooks.help')
  end

  def yes!
    respond_with :message, text: present_schedule_for_weekday(Time.now.prev_day.wday)
  end

  def tod!
    respond_with :message, text: present_schedule_for_weekday(Time.now.wday)
  end

  def tom!
    respond_with :message, text: present_schedule_for_weekday(Time.now.next_day.wday)
  end

  def tt!
    respond_with :message, text: present_week_schedule
  end

  def ping!
    respond_with :message, text: 'pong'
  end

  def action_missing(action, *_args)
    send("#{message}!") if RESTRICTED_MESSAGES.exclude?(message) # Do you know what crutch really means?
  rescue NoMethodError
    respond_with :message, text: t('telegram_webhooks.action_missing', username: username)
  end

  private

  def message
    update['message']['text'].downcase.delete('/')
  end

  def username
    from['first_name'] || from['username']
  end
end
