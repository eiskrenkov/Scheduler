module SchedulePresenter
  WEEKENDS_IDS = [0, 6].freeze

  def weekday_schedule_for(weekday_id)
    return t('.weekday.no_pairs', weekday: weekday_name(weekday_id)) if WEEKENDS_IDS.include? weekday_id

    message = t('.weekday.schedule_for', weekday: weekday_name(weekday_id))
    Weekday.find(weekday_id).pairs.each do |pair|
      message << "\n#{pair.start_time} - #{pair.name}, #{t('.weekday.place', number: pair.place)}"
    end
    message
  end

  private

  def weekday_name(number)
    Weekday.all.pluck(:name)[number]
  end
end