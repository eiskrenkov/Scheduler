class Api::Client::VBsu < Api::Client::Base
  def settings
    handle_errrors({}) do
      settings = get('admin/getProperties', appId: application_id).deep_symbolize_keys
      return {} unless (values = settings.try(:[], :values))

      values.inject({}) do |memo, value|
        memo.merge(value[:key].to_sym => value[:value])
      end
    end
  end

  def update(params)
    handle_errrors(false) do
      post('admin/setProperties', params.merge(appId: application_id))
    end
  end

  private

  def default_api_host
    Settings::VBsu.instance.host
  end

  def default_api_secret
    Settings::VBsu.instance.api_secret
  end

  def application_id
    Settings::VBsu.instance.application_id
  end
end
