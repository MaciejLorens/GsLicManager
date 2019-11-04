class CreateUserLicenses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_licenses do |t|
      t.references :app, foreign_key: true
      t.references :app_version, foreign_key: true
      t.string :version_no
      t.integer :scales_amount
      t.string :license_type
      t.string :old_app_code
      t.string :end_client_desc
      t.string :description
      t.string :new_app_code

      t.timestamps
    end
  end
end
