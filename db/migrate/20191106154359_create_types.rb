class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :value,              null: false
      t.string :pl,                 null: false
      t.string :en,                 null: false
      t.boolean :hidden,            null: false, default: false
      t.datetime :hidden_at,        null: true

      t.timestamps
    end
  end
end
