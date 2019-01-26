class Weekday < ApplicationRecord
  has_many :pairs

  scope :except_sunday, -> { where.not(id: 0) }
end