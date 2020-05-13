# == Schema Information
#
# Table name: schedules
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  target_type :string(255)
#  target_id   :bigint
#

class Schedule < ApplicationRecord
  belongs_to :target, polymorphic: true

  has_many :weekdays, dependent: :destroy

  before_create :create_default_weekdays

  def working_days
    weekdays.except_sunday
  end

  def nearest_days
    weekdays.where(number: [Time.now.wday, Time.now.next_day.wday])
  end

  private

  def create_default_weekdays
    self.weekdays = Weekdays.list.map.with_index do |weekday, index|
      Weekday.new(number: index, name: weekday)
    end
  end
end
