require 'active_support/concern'

module SchedulePresenter
  extend ActiveSupport::Concern

  included do
    Weekdays.keys.each_with_index do |weekday, index|
      define_method("#{weekday}!") do
        respond_with :message, text: present_schedule_for_weekday(index)
      end
    end
  end

  def present_schedule_for_weekday(id)
    weekday = Weekday.find(id)
    return no_pairs_for(weekday) if weekday.weekend?

    "#{Weekdays.t(weekday.name)}\n#{weekday.fetch_pairs}"
  end

  def present_week_schedule
    schedule = t('.schedule.header', semester: Schedule.current_semester)
    Weekday.all.find_each do |weekday|
      schedule << "#{Weekdays.t(weekday.name)} #{weekday.fetch_pairs}\n\n" if weekday.pairs.present?
    end
    schedule
  end

  private

  def no_pairs_for(weekday)
    t('.weekday.no_pairs', weekday: Weekdays.t(weekday.name))
  end
end
