class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.string :email,          null: false
      t.string :locale,         null: false
      t.string :token,          null: false
      t.string :role,           null: false
      t.integer :client_id,     null: true, default: nil
      t.datetime :sent_at,      null: true

      t.timestamps
    end

    # add_index :invitations, :role
    # add_index :invitations, :client_id

  end
end
