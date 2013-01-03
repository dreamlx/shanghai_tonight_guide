class RemoveColumnFromPlace < ActiveRecord::Migration
  def up
    remove_column :places, :photo
  end

  def down
    add_column :places, :photo, :string
  end
end
