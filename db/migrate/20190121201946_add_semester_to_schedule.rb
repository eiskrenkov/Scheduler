class AddSemesterToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :semester, :integer
  end
end
