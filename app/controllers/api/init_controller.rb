class Api::InitController < Api::ApplicationSignedController
  def index
    api_response(InitialDataPresenter.instance.present)
  end
end
