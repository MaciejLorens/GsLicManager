class CreateLicenseTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :license_types do |t|
      t.string :val_pl
      t.string :val_en
      t.integer :is_deleted, default: 0

      t.timestamps
    end
  end
end
