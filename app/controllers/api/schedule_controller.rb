class Api::ScheduleController < Api::ApplicationSignedController
  def index
    api_response(SchedulePresenter.new(Group.all).present)
  end
end
