module ButtonsHelper
  def submit_button(text, options = {})
    button_tag(text, type: :submit, class: merge_css('btn btn-primary', options[:class]))
  end

  def bootstrap_button(text, url, options = {})
    css = merge_css("btn btn-#{options.delete(:btn_style) || 'primary'}", options.delete(:class))
    link_to(text, url, options.merge(class: css))
  end

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

  def save_button(options = {})
    default_options = {
      title: t('shared.save'),
      type: :submit,
      class: 'btn-primary'
    }

    icon_button 'save', default_options.deep_merge(options)
  end

  def cancel_button(options = {})
    default_options = {
      title: t('shared.cancel'),
      class: 'btn-primary'
    }

    options[:url] ||= root_path

    icon_button 'ban', default_options.merge(options)
  end
end
