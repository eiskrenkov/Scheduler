# == Schema Information
#
# Table name: applications
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      not null
#  application_id     :integer          not null
#  request_timeout    :integer          not null
#  api_secret         :string(255)      not null
#  validate_signature :boolean          default(TRUE), not null
#  validate_timestamp :boolean          default(TRUE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Application < ApplicationRecord
  validates :name, :application_id, presence: true
end
