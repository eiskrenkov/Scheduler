class Admin::WeekdaysController < Admin::PermissionController
  defaults resource_class: Weekday
end
