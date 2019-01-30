module SchedulePresenter
  WEEKENDS_IDS = [0, 6].freeze

  def present_schedule_for_weekday(id)
    return t('.weekday.no_pairs', weekday: weekday_name(id)) if WEEKENDS_IDS.include? id

    message = t('.weekday.schedule_for', weekday: weekday_name(id))
    message << fetch_weekday(id)
  end

  def present_week_schedule
    schedule = t('.schedule.header', semester: current_semester)
    Weekday.all.each do |weekday|
      schedule << "#{weekday.name} #{fetch_weekday(weekday.id)}\n\n" if weekday.pairs.present?
    end
    schedule
  end

  private

  def fetch_weekday(id)
    weekday_schedule = ''
    Weekday.find(id).pairs.each do |pair|
      weekday_schedule << "\n#{pair.start_time} - #{pair.name}"
      weekday_schedule << ", #{pair.fetch_kind}" if pair.fetch_kind
      weekday_schedule << ", #{pair.place}" if pair.place
    end
    weekday_schedule
  end

  def weekday_name(number)
    Weekday.all.pluck(:name)[number]
  end

  def current_semester
    Schedule.last.semester
  end
end