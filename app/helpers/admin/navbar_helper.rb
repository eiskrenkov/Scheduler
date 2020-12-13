module Admin::NavbarHelper
  def admin_navbar_brand
    link_to("#{application_title} Admin", root_path, class: 'navbar-brand')
  end

  def admin_navbar_application_settings_link
    navbar_link(t('navbar.admin.settings'), admin_application_settings_path, section: 'admin/application_settings')
  end

  def admin_navbar_v_bsu_settings_link
    navbar_link(t('shared.v_bsu_settings'), admin_v_bsu_settings_path, section: 'admin/v_bsu_settings')
  end

  def admin_navbar_groups_link
    navbar_link(t('navbar.admin.groups'), admin_groups_path, section: 'admin/groups')
  end
end
