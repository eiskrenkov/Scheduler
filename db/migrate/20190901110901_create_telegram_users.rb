class CreateTelegramUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :telegram_users do |t|
      t.belongs_to :group, index: true

      t.integer :telegram_id, null: false
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.string :username, null: false, default: ''

      t.timestamps
    end
  end
end
