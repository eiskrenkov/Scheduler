class Web::Personal::UserController < Web::Personal::BaseController
  alias resource current_user

  navigation_section :profile

  def update
    resource.update(permitted_params)
    redirect_to personal_profile_path
  end

  private

  def permitted_params
    params.require(:user).permit(:group_id)
  end
end
