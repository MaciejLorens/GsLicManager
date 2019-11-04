class AddBlockDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :block_date, :datetime
  end
end
