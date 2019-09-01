class Telegram::PairPresenter < BasePresenter
  attr_reader :pair

  def initialize(pair)
    @pair = pair
  end

  def present
    ["#{pair.start_time} - #{pair.name}", pair.kind_humanize, pair.place].compact.join(', ')
  end
end
