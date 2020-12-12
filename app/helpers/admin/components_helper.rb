module Admin::ComponentsHelper
  def table_tag(options = {}, &block)
    options[:class] = merge_css(options[:class], %w[table table-hover])
    tag.table(capture(&block), options)
  end

  def updated_at_in_words(instance)
    "#{time_ago_in_words(instance.updated_at)} ago".capitalize
  end

  def bootstrap_resource_card(options = {}, &block)
    tag.div(class: 'card resource') do
      tag.div(class: 'card-body') do
        header = options[:header] ||
                 build_bootstrap_resource_card_header(*options.values_at(:prefix, :hide_resource_id))

        safe_join([tag.h2(header), tag.hr, capture(&block)])
      end
    end
  end

  def build_bootstrap_resource_card_header(prefix, hide_resource_id)
    card_header_components = [resource_class.model_name.human]

    card_header_components.prepend(prefix.capitalize) if prefix
    card_header_components << "##{resource.id}" if !hide_resource_id && resource.persisted?

    card_header_components.join(' ')
  end
end
