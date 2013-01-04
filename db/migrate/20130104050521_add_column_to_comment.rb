class AddColumnToComment < ActiveRecord::Migration
  def change
    add_column :comments, :recommend, :string
    add_column :comments, :price, :string
  end
end
