class AddUserIdToUserLicenses < ActiveRecord::Migration[5.2]
  def change
    add_column :user_licenses, :user_id, :integer
  end
end
