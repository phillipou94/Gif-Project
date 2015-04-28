class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.integer :user_id
      t.string :mp4
      t.string :url
      t.string :description
      t.string :title

      t.timestamps null: false
    end
  end
end
