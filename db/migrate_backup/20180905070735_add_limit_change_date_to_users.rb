class AddLimitChangeDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :limit_change_date, :date
  end
end
