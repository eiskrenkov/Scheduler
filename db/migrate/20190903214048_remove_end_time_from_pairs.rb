class RemoveEndTimeFromPairs < ActiveRecord::Migration[5.2]
  def change
    remove_column :pairs, :end_time, :string
  end
end
