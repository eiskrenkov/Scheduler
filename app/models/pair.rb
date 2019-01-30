class Pair < ApplicationRecord
  def fetch_kind
    PairKinds.t(PairKinds.list[kind])
  end
end