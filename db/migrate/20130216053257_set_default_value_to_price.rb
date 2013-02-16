class SetDefaultValueToPrice < ActiveRecord::Migration
  def up
    change_column :places, :price, :decimal, :null=> false, :default => 0
  end

  def down
  end
end
