class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.string :value,                null: false
      t.string :number,               null: false
      t.integer :app_id,              null: false

      t.timestamps
    end
  end
end
