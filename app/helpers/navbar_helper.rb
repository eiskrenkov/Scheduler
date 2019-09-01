module NavbarHelper
  def navbar_tag(&block)
    content_tag(:nav, class: "nav navbar navbar-#{Rails.env} navbar-expand-lg fixed-top navbar-dark bg-dark") do
      content_tag(:div, capture(&block), class: 'container')
    end
  end

  def navbar_brand
    link_to("#{Rails.application.class.parent_name} #{Rails.env.capitalize}", root_path, class: 'navbar-brand')
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

  def navbar_authentication_url
    if current_web_user
      navbar_link(t('navbar.sign_out'), destroy_web_user_session_path, method: :delete)
    else
      navbar_link(t('navbar.sign_in'), new_web_user_session_path)
    end
  end
end
