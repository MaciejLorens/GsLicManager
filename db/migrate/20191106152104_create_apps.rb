class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :name,                 null: false
      t.boolean :hidden,            null: false, default: false
      t.datetime :hidden_at,        null: true

      t.timestamps
    end

    # add_index :apps, :hidden

  end
end
