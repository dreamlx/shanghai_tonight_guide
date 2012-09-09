class RenameUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :token_authenticatable
  	add_column :users, :authentication_token, :string
  end

  def down
  	remove_column :users, :authentication_token
  end
end
