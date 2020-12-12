class Web::Personal::ScheduleController < Web::Personal::BaseController
  inherit_resources
  defaults resource_class: Group

  navigation_section 'personal/schedule'
end
