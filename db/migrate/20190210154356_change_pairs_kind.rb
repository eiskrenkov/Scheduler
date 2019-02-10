class ChangePairsKind < ActiveRecord::Migration[5.2]
  def change
    change_column :pairs, :kind, :string
  end
end
