# == Schema Information
#
# Table name: telegram_users
#
#  id          :bigint           not null, primary key
#  group_id    :bigint
#  telegram_id :integer          not null
#  first_name  :string(255)      default(""), not null
#  last_name   :string(255)      default(""), not null
#  username    :string(255)      default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TelegramUser < ApplicationRecord
  belongs_to :group, optional: true

  validates :telegram_id, presence: true
end
