class Api::BaseController < ApplicationController
  wrap_parameters false

  rescue_from ActiveRecord::RecordNotFound, with: :respond_with_error

  def api_response(object, options = nil)
    response_data = { json: object.as_json, status: :ok }
    response_data.merge!(options) if options
    render response_data
  end

  private

  def respond_with_error(exception)
    api_response({ message: exception.message }, status: :unprocessable_entity)
  end
end
