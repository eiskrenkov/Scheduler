class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :application_title, null: false, default: 'Scheduler'
      t.string :repo_url, null: false, default: ''
      t.string :telegram_bot_url, null: false, default: ''

      t.string :v_bsu_host, null: false, default: ''
      t.string :v_bsu_api_secret, null: false, default: ''
      t.integer :v_bsu_application_id, null: false, default: 1

      t.timestamps
    end
  end
end
