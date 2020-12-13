# == Schema Information
#
# Table name: application_settings
#
#  id                :bigint           not null, primary key
#  application_title :string(255)      default("Scheduler"), not null
#  repo_url          :string(255)      default(""), not null
#  telegram_bot_url  :string(255)      default(""), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Settings::Application < Settings::Base
  self.table_name = :application_settings

  validates :application_title, presence: true
end
