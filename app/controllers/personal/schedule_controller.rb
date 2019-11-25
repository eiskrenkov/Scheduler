class Personal::ScheduleController < Personal::AuthorizedController
  defaults resource_class: Group

  navigation_section :schedule
end
