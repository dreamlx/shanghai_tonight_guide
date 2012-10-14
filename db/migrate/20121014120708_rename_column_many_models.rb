class RenameColumnManyModels < ActiveRecord::Migration
  def up
    rename_column :areas, :area, :area_name
    rename_column :cities, :city, :city_name
    rename_column :provinces, :province, :province_name
  end

  def down
  end
end
