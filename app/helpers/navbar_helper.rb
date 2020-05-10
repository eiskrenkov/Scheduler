module NavbarHelper
  def navbar_tag(&block)
    content_tag(:nav, class: "nav navbar navbar-#{Rails.env} navbar-expand-lg fixed-top navbar-#{current_theme}") do
      content_tag(:div, capture(&block), class: 'container')
    end
  end

  def navbar_toggle_button
    icon_button(
      'bars', class: 'navbar-toggler', data: { toggle: 'collapse', target: '#collapse-content' },
              aria: { controls: 'collapse-content', expanded: false, label: 'toggle' }
    )
  end

  def navbar_toggle_content(&block)
    content_tag(:div, capture(&block), class: 'collapse navbar-collapse', id: 'collapse-content')
  end

  def navbar_brand
    link_to(t('navbar.title'), root_path, class: 'navbar-brand')
  end

  def navbar_links_set(position: :auto, &block)
    content_tag(:ul, capture(&block), class: "navbar-nav mr-#{position}")
  end

  def navbar_link(text, url, options = {})
    section = options.delete(:section)
    active = options.delete(:active) || (section && belongs_to_navigation_section?(section))
    css = { class: 'nav-link ' + (active ? 'active' : '') }
    content_tag(:li, link_to(text, url, options.merge(css)), class: 'nav-item')
  end

  def navbar_schedule_url
    text = if current_group
             t('navbar.schedule_with_time', ago: time_ago_in_words(current_group.schedule.updated_at))
           else
             t('navbar.schedule')
           end

    navbar_link(text, dashboard_schedule_index_path, section: :schedule)
  end

  def navbar_today_url
    navbar_link(t('navbar.today'), dashboard_today_index_path, section: :today)
  end

  def navbar_trello_url
    navbar_link(
      safe_join([fa_icon('trello'), ' ', t('navbar.trello')]),
      'https://trello.com/b/cBcOLtfp', target: '_blank'
    )
  end

  def navbar_bot_url
    navbar_link(
      safe_join([fa_icon('window-restore'), ' ', t('navbar.bot')]),
      'https://t.me/SkafferBot', target: '_blank'
    )
  end

  def navbar_repo_url
    navbar_link(
      safe_join([fa_icon('github'), ' ', t('navbar.github')]),
      'https://github.com/eiskrenkov/SkafferBot', target: '_blank'
    )
  end

  def navbar_set_theme_url
    new_theme = available_themes.find { |theme| theme != cookies[:theme] }
    navbar_link(
      fa_icon('adjust'), dashboard_set_theme_path(theme: new_theme), method: :post
    )
  end

  def navbar_authentication_url
    return if current_web_user

    navbar_link(
      safe_join([fa_icon('sign-in'), ' ', t('shared.log_in')]), new_web_user_session_path
    )
  end
end
