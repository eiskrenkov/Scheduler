require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

# rubocop:disable Style/ClassAndModuleChildren
module Scheduler
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = :ru
  end
end
# rubocop:enable Style/ClassAndModuleChildren
