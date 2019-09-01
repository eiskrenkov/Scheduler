class ApplicationController < ActionController::Base
  include Controllers::Navigation

  protect_from_forgery with: :null_session
end
