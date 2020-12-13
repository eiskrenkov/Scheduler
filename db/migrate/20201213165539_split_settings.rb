class SplitSettings < ActiveRecord::Migration[6.0]
  def up
    drop_table :settings

    create_table :application_settings do |t|
      t.string :application_title, null: false, default: 'Scheduler'
      t.string :repo_url, null: false, default: ''
      t.string :telegram_bot_url, null: false, default: ''

      t.timestamps
    end

    create_table :v_bsu_settings do |t|
      t.string :host, null: false, default: ''
      t.string :api_secret, null: false, default: ''
      t.integer :application_id, null: false, default: 1

      t.timestamps
    end
  end

  def down
    drop_table :application_settings
    drop_table :v_bsu_settings

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
