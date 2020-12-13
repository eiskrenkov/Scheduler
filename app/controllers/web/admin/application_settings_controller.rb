class Web::Admin::ApplicationSettingsController < Web::Admin::BaseController
  inherit_resources
  defaults resource_class: Settings::Application

  navigation_section 'admin/application_settings'

  def update
    update! { request.referer }
  end

  def page_wrapper_options
    { class: 'container' }
  end

  protected

  def resource
    Settings::Application.instance
  end

  private

  def permitted_params
    params.permit!
  end
end
