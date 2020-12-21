class Web::Admin::ApplicationsController < Web::Admin::BaseController
  inherit_resources!
  defaults resource_class: Application, route_prefix: :admin

  navigation_section 'admin/applications'

  def page_wrapper_options
    { class: 'container' }
  end

  private

  def permitted_params
    params.permit(application: %i[name request_timeout application_id api_secret validate_signature validate_timestamp])
  end
end
