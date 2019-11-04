class AddSendToToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :send_to, :string
  end
end
