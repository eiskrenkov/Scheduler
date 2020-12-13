class PairPresenter < BasePresenter
  attr_reader :pair

  def initialize(pair)
    @pair = pair
  end

  def present
    {
      name: pair.name,
      kind: pair.kind,
      place: pair.place,
      teacher: pair.teacher,
      start_time: pair.start_time
    }
  end
end
