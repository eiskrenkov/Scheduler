module Admin::NavbarHelper
  def admin_navbar_brand
    link_to("#{application_title} Admin", root_path, class: 'navbar-brand')
  end

  def admin_navbar_settings_link
    navbar_link(t('navbar.admin.settings'), admin_settings_path, section: 'admin/settings')
  end

  def admin_navbar_groups_link
    navbar_link(t('navbar.admin.groups'), admin_groups_path, section: 'admin/groups')
  end
end
