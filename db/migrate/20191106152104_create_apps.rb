class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :name,                 null: false

      t.timestamps
    end
  end
end
