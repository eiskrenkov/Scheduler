class Api::ApplicationSignedController < Api::BaseController
  include Api::Protection

  attr_reader :application

  before_action :find_application, prepend: true

  private

  def find_application
    @application = Application.find_by!(application_id: params[:application_id])
  end
end
