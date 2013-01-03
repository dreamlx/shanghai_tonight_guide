class AddColumnToPlace < ActiveRecord::Migration
  def change
    add_column :places, :photo, :string
    add_column :places, :thumb_url, :string
  end
end
