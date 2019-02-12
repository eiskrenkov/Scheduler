class PairsController < ApplicationController
  before_action :set_pair, only: %i[destroy]

  def destroy
    @pair.destroy
    redirect_back fallback_location: root_path
  end

  private

  def set_pair
    @pair = Pair.find(params[:id])
  end
end
