class Schedule < ApplicationRecord
  has_many :weekdays, dependent: :destroy

  def self.current_semester
    last.semester
  end
end
