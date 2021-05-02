class Api::TelegramController < Api::ApplicationSignedController
  def set_group
    group = Group.find_by(name: params[:group_name])
    raise Exceptions::GroupDoesNotExist, 'Group with passed name does not exist' unless group

    user.update(group: group)

    head :no_content
  end

  def user
    @user ||= User.find_by(telegram_id: params[:telegram_id].to_i).tap do |user|
      raise Exceptions::UserDoesNotExist, 'User with passed telegram id does not exist' unless user
    end
  end
end
