# == Schema Information
#
# Table name: pairs
#
#  id         :bigint           not null, primary key
#  start_time :string(255)
#  end_time   :string(255)
#  place      :string(255)
#  name       :string(255)
#  weekday_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  kind       :string(255)      default("0")
#

class Pair < ApplicationRecord
  belongs_to :weekday

  def fetch_kind
    PairKinds.t(kind)
  end

  def name_with_info
    return name if kind.blank?

    "#{name}, #{fetch_kind}"
  end
end
