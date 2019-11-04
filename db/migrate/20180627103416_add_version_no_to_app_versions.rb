class AddVersionNoToAppVersions < ActiveRecord::Migration[5.2]
  def change
    add_column :app_versions, :version_no, :integer
  end
end
