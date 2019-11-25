class Personal::TodayController < Personal::AuthorizedController
  defaults resource_class: Group

  navigation_section :today
end
