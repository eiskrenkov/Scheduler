class CreateWeekdays < ActiveRecord::Migration[5.2]
  def change
    create_table :weekdays do |t|
      t.string :name, null: false
      t.integer :number, null: false

      t.belongs_to :schedule, index: true
      t.timestamps
    end
  end
end
