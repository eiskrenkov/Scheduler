class Api::Signature
  SIGNATURE_KEY = 'signature'.freeze
  ALGORITHM = 'sha256'.freeze

  attr_reader :api_secret

  def initialize(api_secret)
    @api_secret = api_secret
  end

  def valid?(data)
    signature = data.delete(SIGNATURE_KEY)
    return false unless signature

    generate_signature(data) == signature
  end

  def generate(data)
    generate_signature(data)
  end

  private

  def generate_signature(data)
    OpenSSL::HMAC.hexdigest(ALGORITHM, api_secret, stringify_data(data))
  end

  def stringify_data(data)
    case data
    when Hash
      data.map do |key, value|
        [stringify_data(key), stringify_data(value)]
      end.flatten.join
    when Array
      data.map do |item|
        stringify_data(item)
      end.join
    else
      data.to_s
    end
  end
end
