module ScheduleHelper
  def schedule_updated_ago
    last_update_time = current_group.schedule.weekdays.order('updated_at').last.updated_at
    I18n.t('navbar.schedule.updated_ago', ago: time_ago_in_words(last_update_time))
  end
end
