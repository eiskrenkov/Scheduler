class Personal::AuthorizedController < InheritedResources::Base
  before_action :authenticate_user!
end
