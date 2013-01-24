class SetDefaultToPlace < ActiveRecord::Migration
  def up
    change_column :places, :thumb_url, :string, :default=>""
  end

  def down
  end
end
