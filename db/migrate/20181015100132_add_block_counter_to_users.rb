class AddBlockCounterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :block_counter, :integer, default: 0
  end
end
