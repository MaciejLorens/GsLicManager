class DeviceCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,                  null: false, default: ''
      t.string :encrypted_password,     null: false, default: ''

      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer :sign_in_count,         null: false, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip

      t.integer :failed_attempts,       null: false, default: 0
      t.string :unlock_token
      t.datetime :locked_at

      t.string :first_name
      t.string :last_name
      t.boolean :hidden,                null: false, default: false
      t.datetime :hidden_at,            null: true
      t.string :locale,                 null: false, default: 'pl'
      t.string :role,                   null: false, default: 'user'
      t.integer :client_id,             null: true, default: nil

      t.timestamps null: false
    end

    # add_index :users, :hidden
    # add_index :users, :unlock_token, unique: true
    # add_index :users, :email, unique: true
    # add_index :users, :reset_password_token, unique: true
    # add_index :users, :client_id

  end
end
