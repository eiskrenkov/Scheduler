class Web::Admin::VBsuSettingsController < Web::Admin::BaseController
  inherit_resources
  defaults resource_class: Settings::VBsu

  navigation_section 'admin/v_bsu_settings'

  def update
    update! { request.referer }
  end

  def update_remote
    if VBsuSettingsUpdater.instance.update(permitted_params[:v_bsu_settings].to_h)
      flash[:notice] = I18n.t('flash.v_bsu_settings_update.success')
    else
      flash[:alert] = I18n.t('flash.v_bsu_settings_update.failure')
    end

    redirect_back fallback_location: root_path
  end

  protected

  def resource
    Settings::VBsu.instance
  end

  private

  def permitted_params
    params.permit!
  end
end
