class Api::GroupsController < Api::ApplicationSignedController
  def schedule
    api_response(GroupPresenter.new(group).present)
  end

  private

  def group
    Group.find(params[:group_id])
  end
end
