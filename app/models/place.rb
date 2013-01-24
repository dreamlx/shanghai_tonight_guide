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
  :thumb_url
  belongs_to :area
  belongs_to :category

  has_many :photos,:as=>:photoable, :dependent => :destroy, :inverse_of => :photoable
  
  def photo
    p = self.photos.first
  end
  #accepts_nested_attributes_for :photos, :allow_destroy => true
  #attr_accessible :photos_attributes, :allow_destroy => true
      
  before_destroy {|record| Photo.destroy_all "photoable_type = 'Place' and photoable_id = #{record.id}"}
  acts_as_commentable

  paginates_per 10

  rails_admin do
    label "场所"
    parent "Area"
    field :name do
      label "场所名字"
    end
    field :address do
      label "地址"
    end
    field :phone do
      label "联系电话"
    end
    field :price do
      label "参考价格"
    end
    field :thumb_url do
      label "第一张照片"
    end
    field :area do
      label "地区"
    end
    field :category do
      label "场所分类"
    end

    field :glng do
      label "位置经度"
    end
    field :glat do
      label "位置纬度"
    end
    field :photos do
      label "场所照片"
    end

    

  end

end
