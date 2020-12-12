module PageWrapperHelper
  def page_wrapper_tag(&block)
    css = merge_css(page_wrapper_options[:class], "theme-#{current_theme}")
    tag.body(capture(&block), page_wrapper_options.merge(class: css))
  end

  def current_theme
    cookies[:theme] || WebTheme.default
  end

  def themed_body_tag(&block)
    tag.body(capture(&block), class: "theme-#{current_theme}")
  end
end
