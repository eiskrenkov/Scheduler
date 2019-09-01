# == Schema Information
#
# Table name: schedules
#
#  id         :bigint           not null, primary key
#  group_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Schedule < ApplicationRecord
  belongs_to :group
  has_many :weekdays, dependent: :destroy

  def working_days
    weekdays.except_sunday
  end

  def weekdays
    super.presence || create_weekdays
  end

  private

  def create_weekdays
    self.weekdays = Weekdays.list.map.with_index do |weekday, index|
      Weekday.create(number: index, name: weekday)
    end.tap { save! } # rubocop:disable Style/MultilineBlockChain
  end
end
