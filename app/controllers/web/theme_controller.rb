class Web::ThemeController < ApplicationController
  def switch
    cookies[:theme] = WebTheme.list.find do |theme|
      theme != cookies.fetch(:theme, WebTheme.default)
    end

    redirect_back fallback_location: root_path
  end
end
