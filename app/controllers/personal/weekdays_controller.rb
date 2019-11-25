class Personal::WeekdaysController < Personal::AuthorizedController
  defaults resource_class: Weekday

  def update
    update! { personal_schedule_index_path }
  end

  def weekday_params
    params.require(:weekday).permit(pairs_attributes: %i[id name start_time kind teacher place _destroy])
  end
end
