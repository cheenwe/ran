class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string, limit: 32
    add_column :users, :name, :string, limit: 100
    add_column :users, :english_name, :string, limit: 100
    add_column :users, :avatar, :string
    add_column :users, :state, :integer, default: 1, null: false
    add_column :users, :type, :string, limit: 20
    add_column :users, :bio, :string
  end
end
