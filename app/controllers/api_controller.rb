class ApiController < ApplicationController
  def current
    render json: Weekday.find(Time.now.wday).pairs
  end

  def weekday
    render json: Weekday.find(params[:id]).pairs
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'No weekday with provided id found' }
  end
end
