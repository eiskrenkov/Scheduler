class Api::ScheduleController < Api::ApplicationSignedController
  def index
    api_response(SchedulePresenter.new.present)
  end
end
