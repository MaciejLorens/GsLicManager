class CreateAppVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :app_versions do |t|
      t.string :value
      t.integer :version_no
      t.boolean :is_deleted
      t.boolean :is_active
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end
