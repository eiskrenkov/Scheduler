module NavbarHelper
  def navbar_tag(&block)
    tag.nav(class: "nav navbar navbar-#{Rails.env} navbar-expand-lg fixed-top navbar-#{current_theme}") do
      tag.div(capture(&block), class: 'container')
    end
  end

  def navbar_toggle_button
    icon_button(
      'bars', class: 'navbar-toggler', data: { toggle: 'collapse', target: '#collapse-content' },
              aria: { controls: 'collapse-content', expanded: false, label: 'toggle' }
    )
  end

  def navbar_toggle_content(&block)
    tag.div(capture(&block), class: 'collapse navbar-collapse', id: 'collapse-content')
  end

  def navbar_brand
    title = application_title
    title << " #{t('navbar.group', name: current_user.group.name)}" if user_signed_in? && current_user.group
    link_to(title, root_path, class: 'navbar-brand')
  end

  def navbar_links_set(position: :auto, &block)
    tag.ul(capture(&block), class: "navbar-nav mr-#{position}")
  end

  def navbar_link(text, url, options = {})
    active = fetch_navigation_section_from(options)
    css = { class: 'nav-link ' + (active ? 'active' : '') }
    tag.li(link_to(text, url, options.merge(css)), class: 'nav-item')
  end

  def navbar_dropdown(title, options = {}, &block)
    indentifier = SecureRandom.uuid
    active = fetch_navigation_section_from(options)

    content = safe_join [
      link_to(
        title, '', class: 'nav-link dropdown-toggle ' + (active ? 'active' : ''), id: indentifier, role: :button,
                   data: { toggle: :dropdown }, aria: { haspopup: true }
      ),
      tag.div(capture(&block), class: 'dropdown-menu', aria: { labelledby: indentifier })
    ]

    tag.li(content, class: 'nav-item dropdown')
  end

  def navbar_dropdown_link(text, url, options = {})
    link_to(text, url, options.merge(class: 'dropdown-item'))
  end

  def navbar_public_schedule_link
    navbar_link(t('navbar.public_schedule'), root_path, section: :public)
  end

  def navbar_personal_today_schedule_link
    navbar_link(t('navbar.personal.today'), personal_today_index_path, section: 'personal/today')
  end

  def navbar_personal_schedule_link
    navbar_link(t('navbar.personal.schedule'), personal_schedule_index_path, section: 'personal/schedule')
  end

  def navbar_bot_link
    navbar_link(
      safe_join([fa_icon('window-restore'), ' ', t('navbar.bot')]),
      Settings.instance.telegram_bot_url, target: '_blank'
    )
  end

  def navbar_repo_link
    navbar_link(
      safe_join([fa_icon('github'), ' ', t('navbar.github')]),
      Settings.instance.repo_url, target: '_blank'
    )
  end

  def navbar_switch_theme_link
    navbar_link(
      fa_icon('adjust'), switch_theme_index_path, method: :post
    )
  end

  def navbar_authentication_section
    if user_signed_in?
      navbar_authentication_dropdown
    else
      navbar_link(safe_join([fa_icon('sign-in'), ' ', t('shared.log_in')]), new_user_session_path)
    end
  end

  def navbar_authentication_dropdown
    navbar_dropdown(current_user.username, section: :profile) do
      safe_join [
        navbar_dropdown_link(
          safe_join([fa_icon('user'), ' ', t('shared.profile')]), personal_profile_path
        ),
        navbar_dropdown_link(
          safe_join([fa_icon('cog'), ' ', t('shared.admin')]), admin_root_path
        ),
        navbar_dropdown_link(
          safe_join([fa_icon('sign-out'), ' ', t('shared.log_out')]), destroy_user_session_path, method: :delete
        )
      ]
    end
  end

  private

  def fetch_navigation_section_from(options)
    section = options.delete(:section)
    options.delete(:active) || (section && belongs_to_navigation_section?(section))
  end
end
