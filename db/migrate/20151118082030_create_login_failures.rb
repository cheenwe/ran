class CreateLoginFailures < ActiveRecord::Migration
  def change
    create_table :login_failures do |t|
      t.string :name
      t.string :ip
      t.string :user_agent

      t.datetime :created_at
    end
  end
end
