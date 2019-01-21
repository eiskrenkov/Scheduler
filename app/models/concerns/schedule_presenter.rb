module SchedulePresenter
  WEEKENDS_IDS = [0, 6].freeze

  def present_schedule_for_weekday(id)
    return t('.weekday.no_pairs', weekday: weekday_name(weekday_id)) if WEEKENDS_IDS.include? id

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
      weekday_schedule << ", #{fetch_kind(pair)}" if fetch_kind(pair)
      weekday_schedule << ", #{pair.place}" if pair.place
    end
    weekday_schedule
  end

  def fetch_kind(pair)
    kinds = { 0 => 'Лекция', 1 => 'Практика', 2 => 'Лаба', 3 => nil, 4 => 'Семинар', 5 => nil }
    kind = kinds[pair.kind]
  end

  def weekday_name(number)
    Weekday.all.pluck(:name)[number]
  end

  def current_semester
    Schedule.last.semester
  end
end