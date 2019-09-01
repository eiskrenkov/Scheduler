module ButtonsHelper
  def submit_button(text, options = {})
    button_tag(text, type: :submit, class: merge_css('btn btn-primary', options[:class]))
  end

  def bootstrap_button(text, url, options = {})
    css = merge_css("btn btn-#{options.delete(:btn_style) || 'primary'}", options.delete(:class))
    link_to(text, url, options.merge(class: css))
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
