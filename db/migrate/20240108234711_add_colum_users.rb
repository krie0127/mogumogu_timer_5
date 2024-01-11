class AddColumUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :line_user_id, :string, null: false
    add_index :users, :line_user_id, unique: true
  end
end
