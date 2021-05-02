class Api::Telegram::BaseController < Api::ApplicationSignedController
  def schedule
    raise NoGroupAssigned, 'User does not have group assigned' unless user.group

    api_response(GroupPresenter.new(user.group).present)
  end

  private

  def user
    @user ||= User.find_by(telegram_id: params[:telegram_id].to_i).tap do |user|
      raise Exceptions::UserDoesNotExist, 'User with passed telegram id does not exist' unless user
    end
  end
end
