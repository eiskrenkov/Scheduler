class BootstrapSelectInput < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options)
    @builder.select(attribute_name, collection, input_options, input_html_options.merge(class: 'selectpicker'))
  end
end
