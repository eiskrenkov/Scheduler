class AddKindToPairs < ActiveRecord::Migration[5.2]
  def change
    add_column :pairs, :kind, :integer, default: 0
  end
end
