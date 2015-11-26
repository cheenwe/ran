class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :name
      t.text :filters
      t.references :user, index: true, foreign_key: true
      t.string :type
      t.boolean :open

      t.timestamps null: false
    end
  end
end
