# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
end
