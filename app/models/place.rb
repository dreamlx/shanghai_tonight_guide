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
  has_many :photos,:as=>:photoable
  
  before_destroy {|record| Photo.destroy_all "photoable_type = 'Place' and photoable_id = #{record.id}"}
  acts_as_commentable

  paginates_per 10
  
  rails_admin do
    list do 
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
      field :area do
        label "区域"
      end
      field :category do
        label "类别"
      end

    end

  end

end
