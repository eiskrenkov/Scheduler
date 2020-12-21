class CreateApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :applications do |t|
      t.string :name, null: false
      t.integer :application_id, null: false
      t.integer :request_timeout, null: false
      t.string :api_secret, null: false
      t.boolean :validate_signature, null: false, default: true
      t.boolean :validate_timestamp, null: false, default: true

      t.timestamps
    end
  end
end
