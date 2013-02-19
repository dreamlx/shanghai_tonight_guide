class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :place_id
      t.string :user_name
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
