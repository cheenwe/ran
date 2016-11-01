class CreateUuidPsqlExtension < ActiveRecord::Migration[5.0]

  def self.up
    execute "CREATE EXTENSION \"uuid-ossp\";"
  end

  def self.down
    execute "DROP EXTENSION \"uuid-ossp\";"
  end
end