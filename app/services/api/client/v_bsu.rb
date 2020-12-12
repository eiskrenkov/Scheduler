class Api::Client::VBsu < Api::Client::Base
  def settings
    handle_errrors({}) do
      settings = get("admin/getProperties/#{application_id}").deep_symbolize_keys
      return {} if settings.empty?

      settings[:values].inject({}) do |memo, value|
        memo.merge(value[:key].to_sym => value[:value])
      end
    end
  end

  def update(params)
    handle_errrors(false) do
      post("admin/setProperties/#{application_id}", params)
    end
  end

  private

  def default_api_host
    Settings.instance.v_bsu_host
  end

  def default_api_secret
    Settings.instance.v_bsu_api_secret
  end

  def application_id
    Settings.instance.v_bsu_application_id
  end
end
