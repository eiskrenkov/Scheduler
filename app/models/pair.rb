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
