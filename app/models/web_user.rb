# == Schema Information
#
# Table name: web_users
#
#  id                 :bigint           not null, primary key
#  email              :string(255)      default(""), not null
#  encrypted_password :string(255)      default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class WebUser < ApplicationRecord
  devise :database_authenticatable, :validatable
end
