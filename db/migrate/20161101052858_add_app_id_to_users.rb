class AddAppIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :app_id, :integer
  end
end
