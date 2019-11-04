class AddIsValidToToken < ActiveRecord::Migration[5.2]
  def change
    add_column :tokens, :is_valid, :boolean
  end
end
