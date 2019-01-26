class AdminController < ApplicationController
  before_action :authenticate_user!

  def home
    @weekdays = Weekday.except_sunday
  end
end
