class Api::WeekdaysController < Api::BaseController
  def current
    api_response(WeekdayPresenter.new(weekday).present)
  end

  private

  def weekday
    schedule.weekdays.find_by(number: current_weekday_number)
  end

  def schedule
    Schedule.find_by(target_type: 'Group', target_id: params[:group_id])
  end

  def current_weekday_number
    DateTime.now.strftime('%u').to_i.pred
  end
end
