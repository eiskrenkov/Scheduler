# == Schema Information
#
# Table name: schedules
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  semester   :integer
#

class Schedule < ApplicationRecord
  has_many :weekdays, dependent: :destroy

  def self.current_semester
    last.semester
  end
end
