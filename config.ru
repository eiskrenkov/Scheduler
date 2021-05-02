# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

map '/ping' do
  run proc { [200, { 'Content-Type' => 'text/html' }, ['OK']] }
end

run Rails.application
