class Web::Admin::GroupsController < Web::Admin::BaseController
  inherit_resources!
  defaults resource_class: Group, route_prefix: :admin

  navigation_section 'admin/groups'

  def schedule
  end

  def page_wrapper_options
    { class: 'container' }
  end

  private

  def permitted_params
    params.permit(group: %i[name])
  end
end
