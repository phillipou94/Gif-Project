class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :words
      t.string :url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
