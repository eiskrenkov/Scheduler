# == Schema Information
#
# Table name: settings
#
#  id                   :bigint           not null, primary key
#  application_title    :string(255)      default("Scheduler"), not null
#  repo_url             :string(255)      default(""), not null
#  telegram_bot_url     :string(255)      default(""), not null
#  v_bsu_host           :string(255)      default(""), not null
#  v_bsu_api_secret     :string(255)      default(""), not null
#  v_bsu_application_id :integer          default(1), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Settings < ApplicationRecord
  before_create :confirm_singularity

  validates :application_title, presence: true

  def self.instance
    first_or_create!
  end

  private

  def confirm_singularity
    errors.add(:base, 'There should be only one Settings instance') if self.class.exists?
  end
end
