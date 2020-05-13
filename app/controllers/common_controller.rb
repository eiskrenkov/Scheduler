class CommonController < InheritedResources::Base
  defaults resource_class: Group

  navigation_section :common

  def set_theme
    cookies[:theme] = params.fetch(:theme, :light)

    redirect_to root_path
  end
end
