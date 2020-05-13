class Admin::WeekdaysController < Admin::AuthorizedController
  defaults resource_class: Weekday
end
