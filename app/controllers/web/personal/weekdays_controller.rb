class Web::Personal::WeekdaysController < Web::Personal::BaseController
  inherit_resources!
  defaults resource_class: Weekday, route_prefix: :personal

  def update
    update! { personal_schedule_index_path }
  end

  def weekday_params
    params.require(:weekday).permit(pairs_attributes: %i[id name start_time kind teacher place _destroy])
  end
end
