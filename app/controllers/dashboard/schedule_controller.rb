class Dashboard::ScheduleController < InheritedResources::Base
  defaults resource_class: Group

  navigation_section :dashboard

  def set_group
    cookies[:group_id] = params[:group_id]

    redirect_to root_path
  end
end
