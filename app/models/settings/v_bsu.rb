# == Schema Information
#
# Table name: v_bsu_settings
#
#  id             :bigint           not null, primary key
#  host           :string(255)      default(""), not null
#  api_secret     :string(255)      default(""), not null
#  application_id :integer          default(1), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Settings::VBsu < Settings::Base
  self.table_name = :v_bsu_settings
end
