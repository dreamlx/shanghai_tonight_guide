class RenameMoreColumnManyModels < ActiveRecord::Migration
  def up
    rename_column :areas, :area_name, :name
    rename_column :cities, :city_name, :name
    rename_column :provinces, :province_name, :name
    rename_column :places, :place_name, :name
    rename_column :categories, :category, :name
  end

  def down
  end
end
