class RemoveColumnFromPlace < ActiveRecord::Migration
  def up
    remove_column :places, :photo
  end

  def down
  end
end
