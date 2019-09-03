class Telegram::PairPresenter < BasePresenter
  attr_reader :pair

  def initialize(pair)
    @pair = pair
  end

  def present
    ["#{pair.start_time} - #{pair.name}", pair.teacher, pair.kind_humanize, pair.place]
      .reject(&:blank?).join(', ') # Do not present empty fields
  end
end
