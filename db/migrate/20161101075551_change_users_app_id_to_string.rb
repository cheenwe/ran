class ChangeUsersAppIdToString < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :app_id, :string
  end
end
