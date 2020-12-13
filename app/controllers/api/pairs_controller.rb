class Api::PairsController < Api::BaseController
  def current
    api_response(pairs: PairsPresenter.new(Time.now.wday).present)
  end
end
