module ApplicationHelper
  def application_name
    "#{Rails.application.class.parent_name} #{Rails.env.capitalize}"
  end

  def merge_css(*css)
    class_list = css.each_with_object([]) do |part, memo|
      case part
      when String
        memo << part.split
      when Array
        memo << part
      end
    end

    class_list.uniq.join(' ')
  end

  def pill(content)
    content_tag(:span, content, class: 'badge badge-primary badge-pill')
  end
end
