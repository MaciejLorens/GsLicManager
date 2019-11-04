class AddIsBlockedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_blocked, :integer, default: 0
  end
end
