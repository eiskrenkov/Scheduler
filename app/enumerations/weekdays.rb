class Weekdays < EnumerateIt::Base
  associate_values :sun, :mon, :tue, :wed, :thu, :fri, :sat

  WEEKENDS = [SAT, SUN].freeze
end
