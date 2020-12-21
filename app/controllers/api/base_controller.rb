class Api::BaseController < ApplicationController
  PARAMS_TO_EXCLUDE = %i[controller action format].freeze

  wrap_parameters false
  rescue_from StandardError, with: :respond_with_error

  def api_response(object, options = nil)
    response_data = { json: object.as_json, status: :ok }
    response_data.merge!(options) if options
    render response_data
  end

  private

  def respond_with_error(exception)
    message = exception.message

    Rails.logger.error(message)
    api_response({ message: message }, status: :unprocessable_entity)
  end

  def permitted_params
    @permitted_params ||= params.except(*PARAMS_TO_EXCLUDE)
                                .permit!.to_h.with_indifferent_access
  end
end
