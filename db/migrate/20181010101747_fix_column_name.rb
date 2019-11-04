class FixColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :user_licenses, :license_type, :license_type_id
  end
end
