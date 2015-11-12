class CreateUsers < ActiveRecord::Migration

  def self.up
    create_table :users,  :id => false  do |t|
      t.uuid :id, :primary_key => true
      t.string :name
      t.string :phone
      t.string :email
      t.string :passwd_salt
      t.string :encrypted_password
      t.string :remember_token
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.string :register_token
      t.datetime :register_token_sent_at
      t.integer :sign_in_count

      t.timestamps null: false
    end
    add_index :users, :id
    add_index :users, :name
    add_index :users, :phone
    add_index :users, :email
   end

   def self.down
     drop_table :users
   end
end
