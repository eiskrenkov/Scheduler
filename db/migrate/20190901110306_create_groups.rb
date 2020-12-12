class CreateGroups < ActiveRecord::Migration[5.2]
  class GroupStub < ApplicationRecord
    self.table_name = :groups
  end

  def up
    create_table :groups do |t|
      t.string :name, null: false

      t.timestamps
    end

    GroupStub.create(name: 'default')
  end

  def down
    drop_table :groups
  end
end
