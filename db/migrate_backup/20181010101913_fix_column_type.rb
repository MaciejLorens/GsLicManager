class FixColumnType < ActiveRecord::Migration[5.2]
  def change
  	change_column :user_licenses, :license_type_id, :integer
  end
end
