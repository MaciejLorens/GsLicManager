class CreateUserApps < ActiveRecord::Migration[5.2]
  def change
    create_table :user_apps do |t|
      t.references :user, foreign_key: true
      t.references :app, foreign_key: true
      t.boolean :is_deleted
      t.boolean :is_active

      t.timestamps
    end
  end
end
