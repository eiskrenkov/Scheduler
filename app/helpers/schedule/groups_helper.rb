module Schedule::GroupsHelper
  def group_is_not_specified_guard(&block)
    current_user&.group ? capture(&block) : render('web/shared/group_is_not_specified')
  end
end
