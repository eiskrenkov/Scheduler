class MergeUsers < ActiveRecord::Migration[5.2]
  def change
    drop_table :telegram_users # rubocop:disable Rails/ReversibleMigration

    rename_table :web_users, :users

    # Destroy current admin users
    User.destroy_all

    change_table :users, bulk: true do |t|
      t.rename :email, :username

      # Groups Support
      t.integer :group_id

      # Rememberable
      t.datetime :remember_created_at

      # Permissions
      t.boolean :admin, default: false

      # Omniauthable
      t.string :provider

      # Telegram Data
      t.integer :telegram_id
      t.string :first_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
    end
  end
end
