module WeekdaysHelper
  def pair_with_time(pair)
    "#{pair.start_time} | #{pair.name}"
  end
end
