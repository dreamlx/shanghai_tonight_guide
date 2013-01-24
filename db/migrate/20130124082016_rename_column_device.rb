class RenameColumnDevice < ActiveRecord::Migration
  def up
    rename_column :devices, :desc, :device_token
  end

  def down
  end
end
