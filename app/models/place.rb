# coding: utf-8
class Place < ActiveRecord::Base
  attr_accessible :address, 
    :area_id, 
    :category_id, 
    :desciption, 
    :glat, 
    :glng, 
    :phone, 
    :name, 
    :price, 
    :user_id,
    :photo,
    :photo_cache,
    :remove_photo
  
  belongs_to :area
  belongs_to :category
  #has_many :albums
  has_many :photos,:as=>:photoable
  #has_one :photo_thumb, :as => :assetable, :class_name => 'PlacePhoto'
  acts_as_commentable
  mount_uploader :photo, PlacePhotoUploader
  paginates_per 10
  
  rails_admin do
    list do 
      field :photo do 
        label "照片"
      end
      field :name do 
        label "單位名稱"
      end
      field :price do
        label "price"
      end
      field :address do
        label "地址"
      end
      field :phone do
        label "聯繫電話"
      end
    end

  end

end
