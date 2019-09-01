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
  has_one :schedule, dependent: :destroy

  validates :name, presence: true

  def schedule
    super || create_schedule
  end

  private

  def create_schedule
    Schedule.create(group_id: id)
  end
end
