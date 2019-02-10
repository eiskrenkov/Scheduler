class AdminController < ApplicationController
  def home
    @weekdays = Weekday.except_sunday
  end
end
