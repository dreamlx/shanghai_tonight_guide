class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :private_token, :string
  end
end
