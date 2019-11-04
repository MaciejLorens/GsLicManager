class AddPrefLangToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pref_lang, :string
  end
end
