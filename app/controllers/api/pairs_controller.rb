class Api::PairsController < Api::BaseController
  def current
    render json: { pairs: PairsPresenter.new(Time.now.wday).present }
  end
end
