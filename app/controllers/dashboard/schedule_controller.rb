class Dashboard::ScheduleController < ApplicationController
  navigation_section :dashboard

  def set_group
    cookies[:group_id] = params[:group_id]

    redirect_to root_path
  end
end
