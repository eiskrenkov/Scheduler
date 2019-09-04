class Dashboard::TodayController < InheritedResources::Base
  defaults resource_class: Group

  navigation_section :today
end
