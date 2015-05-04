class AddNameToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :password_confirmation, :string
  end
end
