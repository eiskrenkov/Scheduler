class AddNameIndexToGroups < ActiveRecord::Migration[6.0]
  def change
    add_index :groups, :name, unique: true
  end
end
