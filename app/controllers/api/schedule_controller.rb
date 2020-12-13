class Api::ScheduleController < Api::BaseController
  def index
    api_response(SchedulePresenter.new.present)
  end
end
