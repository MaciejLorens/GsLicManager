class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :val_pl,             null: false
      t.string :val_en,             null: false
      t.boolean :hidden,            null: false, default: false
      t.datetime :hidden_at,        null: true
      t.integer :app_id,              null: false

      t.timestamps
    end

    # add_index :licenses, :hidden
    # add_index :app_id, :hidden

  end
end
