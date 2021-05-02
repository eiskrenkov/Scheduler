class AddIndiciesToUser < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :telegram_id, unique: true
  end
end
