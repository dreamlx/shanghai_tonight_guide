class Place < ActiveRecord::Base
  attr_accessible :address, :area_id, :category_id, :desciption, :glat, :glng, :phone, :name, :price, :user_id
  belongs_to :area
  belongs_to :category
  
  paginates_per 10
end
