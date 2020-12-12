class Web::Admin::SettingsController < Web::Admin::BaseController
  inherit_resources
  defaults resource_class: Settings

  navigation_section 'admin/settings'

  def update_v_bsu_settings
    if VBsuSettingsUpdater.instance.update(permitted_params[:v_bsu_settings].to_h)
      flash[:notice] = I18n.t('flash.v_bsu_settings_update.success')
    else
      flash[:alert] = I18n.t('flash.v_bsu_settings_update.failure')
    end

    redirect_back fallback_location: root_path
  end

  def update
    update! { request.referer }
  end

  protected

  def resource
    Settings.instance
  end

  private

  def permitted_params
    params.permit!
  end
end
