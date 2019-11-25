class CommonController < InheritedResources::Base
  # before_action { redirect_to personal_today_index_path if user_signed_in? }

  defaults resource_class: Group

  navigation_section :common

  def set_theme
    cookies[:theme] = params.fetch(:theme, :light)

    redirect_to root_path
  end
end
