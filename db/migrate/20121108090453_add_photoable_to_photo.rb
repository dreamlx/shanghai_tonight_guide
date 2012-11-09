class AddPhotoableToPhoto < ActiveRecord::Migration
  def change
  	remove_column :photos, :album_id   
  	add_column :photos, :photoable_id, :integer  	  	 	
  	add_column :photos, :photoable_type, :string

     add_index :photos, :photoable_type
     add_index :photos, :photoable_id 	  	  	  	
  end
end
