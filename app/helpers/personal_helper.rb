module PersonalHelper
  def groups_to_select
    safe_join [
      Group.all.map do |group|
        content_tag(:option, group.name, value: personal_update_profile_path(user: { group_id: group.id }))
      end
    ]
  end

  def personal_weekdays_for_rendering
    current_user_group_schedule.weekdays.zip(current_user_personal_schedule.weekdays)
  end

  def personal_nearest_weekdays_for_rendering
    current_user_group_schedule.nearest_days.zip(current_user_personal_schedule.nearest_days)
  end

  # rubocop:disable Rails/HelperInstanceVariable
  def current_user_personal_schedule
    @current_user_personal_schedule ||= current_user.schedule
  end

  def current_user_group_schedule
    @current_user_group_schedule ||= current_user.group.schedule
  end
  # rubocop:enable Rails/HelperInstanceVariable
end
