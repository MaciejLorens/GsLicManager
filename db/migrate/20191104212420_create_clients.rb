class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name,               null: false
      t.string :locale,             null: false, default: 'en'
      t.boolean :hidden,            null: false, default: false
      t.datetime :hidden_at,        null: true

      t.timestamps
    end
  end
end
