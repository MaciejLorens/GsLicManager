class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :value_pl,             null: false
      t.string :value_en,             null: false
      t.integer :app_id,              null: false

      t.timestamps
    end
  end
end