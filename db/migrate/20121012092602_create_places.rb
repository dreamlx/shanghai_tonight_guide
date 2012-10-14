class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :place_name
      t.integer :area_id
      t.string :address
      t.integer :category_id
      t.integer :user_id
      t.text :desciption
      t.string :glat
      t.string :glng
      t.decimal :price
      t.string :phone

      t.timestamps
    end
  end
end
