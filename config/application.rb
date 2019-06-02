require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

# rubocop:disable Style/ClassAndModuleChildren
module SkafferBot
  class Application < Rails::Application
    config.load_defaults 5.2

    config.i18n.default_locale = :ru
  end
end
# rubocop:enable Style/ClassAndModuleChildren
