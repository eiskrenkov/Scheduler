# frozen_string_literal: true

SimpleForm.setup do |config|
  config.wrappers :default, class: :input, hint_class: :field_with_hint,
                            error_class: :field_with_errors, valid_class: :field_without_errors do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn'

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  config.browser_validations = false

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'
end
