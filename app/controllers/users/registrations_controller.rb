class Users::RegistrationsController < Devise::RegistrationsController
  include Web::NavigationSupport
  include Web::PageWrapperSupport

  private

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation, :group_id)
  end
end
