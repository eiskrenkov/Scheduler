# == Schema Information
#
# Table name: pairs
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  start_time :string(255)      not null
#  kind       :string(255)      default(""), not null
#  place      :string(255)      default(""), not null
#  weekday_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  teacher    :string(255)      default(""), not null
#

class Pair < ApplicationRecord
  belongs_to :weekday

  has_enumeration_for :kind, with: ::PairKinds, create_scopes: true, create_helpers: true

  validates :name, :start_time, presence: true
end
