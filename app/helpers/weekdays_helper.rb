module WeekdaysHelper
  def remove_association_button(form)
    link_to_remove_association fa_icon('trash'), form, class: 'btn btn-danger pull-right'
  end

  def list_item(&block)
    content_tag(:div, capture(&block),
                class: 'list-group-item list-group-item-action d-flex justify-content-between align-items-center')
  end
end
