class CreateGirls < ActiveRecord::Migration
  def change
    create_table :girls do |t|
      t.string :name
      t.integer :age
      t.string :livein
      t.text :desc

      t.timestamps
    end
  end
end
