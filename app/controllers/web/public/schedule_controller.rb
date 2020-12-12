class Web::Public::ScheduleController < Web::BaseController
  layout Layout::APPLICATION

  inherit_resources
  defaults resource_class: Group

  navigation_section :public

  def index
    @groups = collection.preload(schedule: { weekdays: :pairs })
  end

  def page_wrapper_options
    { class: 'container' }
  end
end
