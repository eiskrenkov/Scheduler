module IconsHelper
  def icon_button(icon, options = {}) # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
    if options.is_a?(String)
      url = options
      options = {}
    else
      url = options.delete(:url)
    end
    type = options.delete(:type) || :link
    title = options.delete(:title)
    size = options.delete(:size)
    css_classes = options.delete(:class).try(:split) || []
    css_classes << 'btn'
    css_classes << "btn-#{size}" if size.present?
    options[:class] = css_classes.join(' ')

    button_html = "#{fa_icon(icon)} #{title}".html_safe # rubocop:disable Rails/OutputSafety

    if type == :link
      link_to(button_html, url, options)
    else
      button_tag(button_html, { type: type }.merge(options))
    end
  end
end
