class AddPlacesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :favorite_place_ids, :integer, :array => true  	
  end
end
