class Web::Personal::BaseController < Web::BaseController
  layout Layout::APPLICATION

  before_action :authenticate_user!
end
