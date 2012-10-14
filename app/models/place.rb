class Place < ActiveRecord::Base
  attr_accessible :address, :area_id, :category_id, :desciption, :glat, :glng, :phone, :place_name, :price, :user_id
  belongs_to :area
  belongs_to :category
end
