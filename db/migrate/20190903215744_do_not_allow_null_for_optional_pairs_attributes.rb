class DoNotAllowNullForOptionalPairsAttributes < ActiveRecord::Migration[5.2]
  def change
    # Pair Kind
    change_column_null :pairs, :kind, false, ''
    change_column_default :pairs, :kind, from: nil, to: ''

    # Pair Place
    change_column_null :pairs, :place, false, ''
    change_column_default :pairs, :place, from: nil, to: ''
  end
end
