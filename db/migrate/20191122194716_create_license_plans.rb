class CreateLicensePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :license_plans do |t|
      t.string :val_pl,             null: false
      t.string :val_en,             null: false
      t.boolean :hidden,            null: false, default: false
      t.datetime :hidden_at,        null: true

      t.timestamps
    end
  end
end
