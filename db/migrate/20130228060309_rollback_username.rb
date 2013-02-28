class RollbackUsername < ActiveRecord::Migration
  def up
    rename_column :users, :username, :name
  end

  def down
  end
end
