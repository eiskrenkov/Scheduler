class Weekday < ApplicationRecord
  has_many :pairs, dependent: :destroy

  scope :except_sunday, -> { where.not(id: 0) }

  def fetch_pairs
    weekday_schedule = ''
    pairs.each do |pair|
      weekday_schedule << "\n#{pair.start_time} - #{pair.name}"
      weekday_schedule << ", #{pair.fetch_kind}" if pair.fetch_kind
      weekday_schedule << ", #{pair.place}" if pair.place
    end
    weekday_schedule
  end

  def weekend?
    Weekdays::WEEKENDS.include? name
  end
end
