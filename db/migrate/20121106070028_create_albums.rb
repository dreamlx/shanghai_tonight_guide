class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.text :desc
      t.integer :user_id
      t.integer :place_id      

      t.timestamps
    end
  end
end
