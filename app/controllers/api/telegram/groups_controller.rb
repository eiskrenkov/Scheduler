class Api::Telegram::GroupsController < Api::Telegram::BaseController
  def list
    api_response(Group.pluck(:name))
  end

  def set
    group = Group.find_by(name: params[:group_name])
    raise Exceptions::GroupDoesNotExist, 'Group with passed name does not exist' unless group

    user.update(group: group)

    head :no_content
  end
end
