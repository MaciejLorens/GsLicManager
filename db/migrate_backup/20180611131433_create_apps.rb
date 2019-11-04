class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :name_app
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
