module Api::Protection
  extend ActiveSupport::Concern

  class InvalidSignature < StandardError; end

  class RequestTimeout < StandardError; end

  included do
    before_action :validate_signature!, if: -> { application.validate_signature }
    before_action :validate_timestamp!, if: -> { application.validate_timestamp }
  end

  private

  def validate_signature!
    return if Api::Signature.new(application.api_secret).valid?(permitted_params)

    raise(InvalidSignature, 'API signature is not valid')
  end

  def validate_timestamp!
    return unless Time.now.to_i - permitted_params[:timestamp].to_i > application.request_timeout

    raise(RequestTimeout, 'Request timed out')
  end

  def application
    raise NotImplementedError
  end
end
