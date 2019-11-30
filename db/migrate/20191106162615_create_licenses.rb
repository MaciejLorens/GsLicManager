class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.integer :client_id,           null: false
      t.integer :app_id,              null: false
      t.integer :version_id,          null: false
      t.integer :plan_id,             null: false
      t.integer :license_type_id,     null: false
      t.integer :license_status_id,   null: false
      t.string :order_number,         null: true
      t.string :end_client_name,      null: false
      t.string :installation_address, null: false
      t.string :description,          null: true
      t.string :registration_key,     null: true
      t.string :unlock_code,          null: true
      t.integer :user_id,             null: true
      t.integer :origin_id,           null: true
      t.boolean :hidden,              null: false, default: false
      t.datetime :hidden_at,          null: true

      t.timestamps
    end
  end
end
