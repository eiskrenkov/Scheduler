class Api::Client::Base
  attr_reader :api_host, :api_secret

  def initialize(api_host = nil, secret = nil)
    @api_host = api_host || default_api_host
    @api_secret = api_secret || default_api_secret
  end

  class Error < StandardError; end

  def get(endpoint, params = {})
    perform_request(:get, endpoint, params)
  end

  def post(endpoint, params = {})
    perform_request(:post, endpoint, params)
  end

  private

  def default_api_host
    raise NotImplementedError
  end

  def default_api_secret
  end

  def perform_request(verb, endpoint, params)
    sign_request(params) if api_secret

    Rails.logger.info(
      "Performing API request: #{verb.upcase} #{api_host}/#{endpoint} with params #{params.as_json}"
    )

    JSON.parse(connection.send(verb, endpoint, params).body).with_indifferent_access.tap do |response|
      Rails.logger.info("Response: #{response}")
    end
  rescue StandardError => e
    Rails.logger.error("API error: #{e.message}")
    raise Error, e.message
  end

  def sign_request(params)
    params.merge!(signature: Api::Signature.new(api_secret).generate(params))
  end

  def handle_errrors(fallback_value)
    yield
  rescue Api::Client::Base::Error
    fallback_value
  end

  def connection
    @connection ||= Faraday.new(api_host)
  end
end
