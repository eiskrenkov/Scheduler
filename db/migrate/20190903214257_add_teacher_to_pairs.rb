class AddTeacherToPairs < ActiveRecord::Migration[5.2]
  def change
    add_column :pairs, :teacher, :string, null: false, default: ''
  end
end
