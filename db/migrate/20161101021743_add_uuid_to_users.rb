class AddUuidToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :uuid, :uuid, :default => "uuid_generate_v4()"
  end
  def down
    remove_column :users, :uuid
  end

end
