class CreateLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :licenses do |t|
      t.string :end_client_name,      null: false
      t.string :end_client_address,   null: false
      t.string :description,          null: true
      t.string :order_number,         null: true
      t.string :registration_key,     null: false
      t.string :unlock_code,          null: true
      t.integer :license_plan_id,     null: false
      t.integer :license_status_id,   null: false
      t.integer :license_type_id,     null: false
      t.integer :version_id,          null: false
      t.integer :app_id,              null: false
      t.integer :user_id,             null: true
      t.integer :client_id,           null: false
      t.boolean :hidden,              null: false, default: false
      t.datetime :hidden_at,          null: true

      t.timestamps
    end
  end
end
