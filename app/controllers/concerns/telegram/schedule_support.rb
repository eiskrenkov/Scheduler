module Telegram::ScheduleSupport
  extend ActiveSupport::Concern

  included do
    Weekdays.keys.each_with_index do |weekday, index|
      define_method("#{weekday}!") do |*|
        send_message present_schedule_for(index)
      end
    end
  end

  def present_schedule_for(weekday_number)
    weekday = current_user.group.schedule.weekdays.find { |w| w.number == weekday_number }
    return I18n.t('telegram.errors.no_pairs') if weekday.pairs.blank?

    Telegram::WeekdayPresenter.new(weekday).present
  end

  def present_schedule
    Telegram::SchedulePresenter.new(current_user).present
  end
end
