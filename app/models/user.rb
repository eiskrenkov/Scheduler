# == Schema Information
#
# Table name: users
#
#  id                  :bigint           not null, primary key
#  username            :string(255)      default(""), not null
#  encrypted_password  :string(255)      default(""), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  group_id            :integer
#  remember_created_at :datetime
#  admin               :boolean          default(FALSE)
#  provider            :string(255)
#  telegram_id         :integer
#  first_name          :string(255)      default(""), not null
#  last_name           :string(255)      default(""), not null
#

class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable, :rememberable, :omniauthable,
         omniauth_providers: %i[telegram], authentication_keys: %i[username]

  belongs_to :group, optional: true
  has_one :schedule, as: :target, dependent: :destroy, inverse_of: :target

  delegate :weekdays, to: :schedule

  validates :username, uniqueness: true

  before_create :build_schedule

  def self.from_omniauth(auth)
    where(provider: auth.provider, telegram_id: auth.uid.to_i).first_or_create do |user|
      user.username = auth.info.username
      user.password = Devise.friendly_token[0, 20]

      user.first_name = auth.info.first_name.presence || ''
      user.last_name = auth.info.last_name.presence || ''
    end
  end
end
