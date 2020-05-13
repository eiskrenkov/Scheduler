# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ApplicationRecord
  has_one :schedule, as: :target, dependent: :destroy, inverse_of: :target
  has_many :users, dependent: :restrict_with_error

  delegate :weekdays, to: :schedule

  validates :name, presence: true, uniqueness: true

  def schedule
    super || create_schedule
  end

  private

  def create_schedule
    Schedule.create(target_id: id, target_type: 'Group')
  end
end
