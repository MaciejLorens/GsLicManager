class UserLicenseChangeColumnDescription < ActiveRecord::Migration[5.2]
  def change
  	change_column :user_licenses, :description, :string
  end
end
