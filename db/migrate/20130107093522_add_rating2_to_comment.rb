class AddRating2ToComment < ActiveRecord::Migration
  def change
    add_column :comments, :rating, :boolean
  end
end
