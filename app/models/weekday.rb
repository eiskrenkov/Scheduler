class Weekday < ApplicationRecord
  has_many :pairs, dependent: :destroy
  accepts_nested_attributes_for :pairs, reject_if: :all_blank, allow_destroy: true

  scope :except_sunday, -> { where.not(id: 0) }

  def fetch_pairs
    weekday_schedule = ''
    pairs.each do |pair|
      weekday_schedule << "\n#{pair.start_time} - #{pair.name}"
      weekday_schedule << ", #{pair.fetch_kind}" if pair.kind.present?
      weekday_schedule << ", #{pair.place}" if pair.place.present?
    end
    weekday_schedule
  end

  def weekend?
    Weekdays::WEEKENDS.include? name
  end
end
