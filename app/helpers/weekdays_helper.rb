module WeekdaysHelper
  def remove_association_button(form)
    link_to_remove_association fa_icon('trash'), form, class: 'btn btn-danger pull-right'
  end

  def list_item(&block)
    content_tag(:div, capture(&block),
                class: 'list-group-item list-group-item-action d-flex justify-content-between align-items-center')
  end

  def weekday_title(weekday)
    return (name = weekday.name_humanize) unless current_user&.admin?

    link_to name, edit_admin_weekday_path(weekday)
  end

  def weekday_name_with_mark(weekday)
    [
      weekday.name_humanize, (" (#{t('shared.today')})" if weekday.number == Time.now.wday)
    ].join(' ')
  end
end
