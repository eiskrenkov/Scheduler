class VBsuSettingsUpdater
  include Singleton

  def update(params)
    api_client.update(values: prepare_updates(params))
  end

  private

  def prepare_updates(params)
    params.map do |key, value|
      { key: key, value: value }
    end
  end

  def api_client
    Api::Client::VBsu.new
  end
end
