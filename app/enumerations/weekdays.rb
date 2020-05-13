class Weekdays < EnumerateIt::Base
  associate_values :mon, :tue, :wed, :thu, :fri, :sat, :sun

  WEEKENDS = [SAT, SUN].freeze
end
