# == Schema Information
#
# Table name: weekdays
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  number      :integer          not null
#  schedule_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Weekday < ApplicationRecord
  belongs_to :schedule

  has_many :pairs, dependent: :destroy, inverse_of: :weekday
  accepts_nested_attributes_for :pairs, reject_if: :all_blank, allow_destroy: true

  scope :except_sunday, -> { where.not(name: Weekdays::SUN) }

  has_enumeration_for :name, with: ::Weekdays

  def weekend?
    Weekdays::WEEKENDS.include?(name)
  end
end
