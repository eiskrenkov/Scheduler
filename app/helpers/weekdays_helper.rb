module WeekdaysHelper
  def pair_with_time(pair)
    "#{pair.start_time} | #{pair.name}"
  end

  def pair_text_field(form, type)
    form.text_field type, placeholder: t("weekday.pair.#{type}"), class: 'form-control'
  end

  def selector(form, type, collection, options = {})
    form.select(type, collection, options, { class: 'custom-select mr-sm-2' })
  end

  def delete_button(form)
    link_to_remove_association '✖', form, class: 'btn btn-danger pull-right'
  end
end
