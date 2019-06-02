# Default Rails configs

Rails.application.config do |config|
  config.active_record.belongs_to_required_by_default = false
  config.filter_parameters += [:password]
  config.action_dispatch.cookies_serializer = :json

  config.assets.version = '1.0'
  config.assets.paths << Rails.root.join('node_modules')
end
