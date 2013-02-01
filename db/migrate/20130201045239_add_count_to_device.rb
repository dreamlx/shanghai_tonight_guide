class AddCountToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :badge_count, :integer
  end
end
