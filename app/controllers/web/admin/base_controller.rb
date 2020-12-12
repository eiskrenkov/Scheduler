class Web::Admin::BaseController < Web::BaseController
  layout Layout::ADMIN

  before_action do
    redirect_back fallback_location: root_path unless current_user&.admin?
  end
end
