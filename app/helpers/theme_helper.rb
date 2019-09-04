module ThemeHelper
  def available_themes
    %w[dark light]
  end

  def current_theme
    cookies[:theme] || :light
  end

  def themed_body_tag(&block)
    content_tag(:body, capture(&block), class: "container theme-#{current_theme}")
  end
end
