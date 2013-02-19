class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :place_id
      t.integer :user_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
