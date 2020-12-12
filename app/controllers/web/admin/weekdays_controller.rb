class Web::Admin::WeekdaysController < Web::Admin::BaseController
  inherit_resources!

  belongs_to :group
  defaults resource_class: Weekday, route_prefix: :admin

  navigation_section 'admin/groups'

  def page_wrapper_options
    { class: 'container' }
  end

  def weekday_params
    params.require(:weekday).permit(pairs_attributes: %i[id name start_time kind teacher place _destroy])
  end
end
