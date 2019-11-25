class MakeSchedulePolymorphic < ActiveRecord::Migration[5.2]
  class SchedulesStub < ApplicationRecord
    self.table_name = :schedules
  end

  def up
    add_reference :schedules, :target, polymorphic: true

    SchedulesStub.all.each do |schedule|
      schedule.target_type = 'Group'
      schedule.target_id = schedule.group_id
      schedule.save
    end

    remove_reference :schedules, :group, index: true
  end

  def down
    add_reference :schedules, :group, index: true

    SchedulesStub.all.each do |schedule|
      schedule.group_id = schedule.target_id
      schedule.save
    end

    remove_reference :schedules, :target, polymorphic: true
  end
end
