class WebTheme < EnumerateIt::Base
  associate_values :light, :dark

  def self.default
    LIGHT
  end
end
