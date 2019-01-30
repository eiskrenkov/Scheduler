class Pair < ApplicationRecord
  PAIRS_KINDS = %w(Лекция Практика Лаба Семинар).freeze

  def fetch_kind
    PAIRS_KINDS[kind]
  end
end