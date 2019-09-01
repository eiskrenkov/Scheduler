module ScheduleHelper
  def schedule_updated_ago
    I18n.t('navbar.schedule.updated_ago', ago: time_ago_in_words(current_group.schedule.updated_at))
  end
end
