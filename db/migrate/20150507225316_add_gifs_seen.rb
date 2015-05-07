class AddGifsSeen < ActiveRecord::Migration
  def change
  	add_column :users,:gifs_seen,:integer
  end
end
