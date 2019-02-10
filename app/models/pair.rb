class Pair < ApplicationRecord
  def fetch_kind
    PairKinds.t(kind)
  end

  def name_with_info
    return name if kind.blank?

    "#{name}, #{fetch_kind}"
  end
end
