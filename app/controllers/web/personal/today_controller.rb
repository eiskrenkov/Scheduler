class Web::Personal::TodayController < Web::Personal::BaseController
  inherit_resources
  defaults resource_class: Group

  navigation_section 'personal/today'

  def page_wrapper_options
    { class: 'container' }
  end
end
