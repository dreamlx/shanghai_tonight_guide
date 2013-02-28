class ChangeUsers < ActiveRecord::Migration
  def up
    add_column :users, :mobile, :string
    rename_column :users, :name, :username
  end

  def down
  end
end
