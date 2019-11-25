class Admin::PermissionController < InheritedResources::Base
  before_action do
    redirect_back fallback_location: root_path unless current_user&.admin?
  end
end
