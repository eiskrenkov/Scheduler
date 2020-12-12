module ButtonsHelper
  def submit_button(text, options = {})
    button_tag(text, type: :submit, class: merge_css('btn btn-primary', options[:class]))
  end

  def bootstrap_button(title, options = {})
    type = options.delete(:type) || :link
    style = build_bootstrap_button_style(options.delete(:btn_style), options.delete(:outline), options.delete(:size))

    default_options = {
      class: merge_css(style, options.delete(:class))
    }

    if type == :link
      link_to(title, options.delete(:url), default_options.merge!(options))
    else
      default_options[:type] = type
      button_tag(title, default_options.merge!(options))
    end
  end

  def build_bootstrap_button_style(style, outline, size)
    ['btn', ' ', 'btn-', ('outline-' if outline), (style || 'primary'), ' ', ("btn-#{size}" if size.present?)].join
  end

  def bootstrap_icon_button(icon, options = {})
    bootstrap_button(
      "#{fa_icon(icon)} #{options.delete(:title)}".html_safe, options # rubocop:disable Rails/OutputSafety
    )
  end

  def new_button(options = {})
    default_options = {
      url: new_resource_path,
      title: t('shared.new'),
      btn_style: 'success'
    }

    bootstrap_icon_button('plus', default_options.merge(options))
  end

  def edit_button(resource, options = {})
    default_options = {
      url: edit_resource_path(resource),
      title: t('shared.edit'),
      btn_style: 'outline-info',
      size: :xs
    }

    bootstrap_icon_button('edit', default_options.merge(options))
  end

  def save_button(options = {})
    default_options = {
      title: t('shared.save'),
      type: :submit
    }

    bootstrap_icon_button('save', default_options.deep_merge(options))
  end

  def cancel_button(options = {})
    default_options = {
      title: t('shared.cancel')
    }

    bootstrap_icon_button('ban', default_options.merge(options))
  end

  def delete_button(resource, options = {})
    default_options = {
      title: t('shared.delete'),
      method: :delete,
      url: resource_path(resource),
      data: { confirm: t('shared.confirmations.deletion', class: resource.class.name) },
      btn_style: 'danger',
      size: :xs
    }

    bootstrap_icon_button('trash', default_options.deep_merge(options))
  end
end
