class PairsPresenter < BasePresenter
  EXCLUDED_FIELDS = %w[id weekday_id created_at].freeze

  def initialize(weekday_id)
    @weekday_id = weekday_id
  end

  def present
    pairs = Weekday.find_by(id: @weekday_id).pairs
    pairs.map { |pair| pair.attributes.except(*EXCLUDED_FIELDS) }
  end
end
