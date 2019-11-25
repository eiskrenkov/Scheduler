module GroupsHelper
  def group_is_not_specified_guard(&block)
    return capture(&block) if current_user&.group

    render 'shared/group_is_not_specified'
  end
end
