class RemovePlaceFromAlbum < ActiveRecord::Migration
  def up
  	remove_column :albums, :place_id  	
  end

  def down
  end
end
