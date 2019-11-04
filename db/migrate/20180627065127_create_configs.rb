class CreateConfigs < ActiveRecord::Migration[5.2]
  def change
    create_table :configs do |t|
      t.string :key
      t.string :value_str1
      t.string :value_str2
      t.string :value_str3
      t.string :value_str4

      t.timestamps
    end
  end
end
