class CreatePairs < ActiveRecord::Migration[5.2]
  def change
    create_table :pairs do |t|
      t.string :start_time
      t.string :end_time
      t.string :place
      t.string :name
      
      t.belongs_to :weekday, index: true
      t.timestamps
    end
  end
end
