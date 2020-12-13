class WeekdayPresenter < BasePresenter
  attr_reader :weekday

  def initialize(weekday)
    @weekday = weekday
  end

  def present
    {
      number: weekday.number,
      pairs: present_pairs
    }
  end

  private

  def present_pairs
    weekday.pairs.map do |pair|
      PairPresenter.new(pair).present
    end
  end
end
