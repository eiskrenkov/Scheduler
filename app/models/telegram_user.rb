# == Schema Information
#
# Table name: telegram_users
#
#  id          :bigint           not null, primary key
#  username    :string(255)      not null
#  telegram_id :integer          not null
#  group_id    :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TelegramUser < ApplicationRecord
  belongs_to :group, optional: true

  validates :telegram_id, presence: true
end
