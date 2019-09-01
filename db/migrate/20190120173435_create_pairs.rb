class CreatePairs < ActiveRecord::Migration[5.2]
  def change
    create_table :pairs do |t|
      t.string :name, null: false

      t.string :start_time, null: false
      t.string :end_time, null: false

      t.string :kind
      t.string :place

      t.belongs_to :weekday, index: true
      t.timestamps
    end
  end
end
