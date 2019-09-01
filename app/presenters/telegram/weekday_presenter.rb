class Telegram::WeekdayPresenter < BasePresenter
  attr_reader :weekday

  def initialize(weekday)
    @weekday = weekday
  end

  def present
    "#{weekday.name_humanize}\n#{present_pairs}"
  end

  private

  def present_pairs
    weekday.pairs.map do |pair|
      Telegram::PairPresenter.new(pair).present
    end.join("\n")
  end
end
