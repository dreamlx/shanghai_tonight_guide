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
  :thumb_url,
  :audit,
  :photo_ids
  belongs_to :area,:inverse_of => :places
  belongs_to :category,:inverse_of => :places

  has_many :photos,:as=>:photoable, :dependent => :destroy, :inverse_of => :photoable
  has_many :reports
  has_many :orders
  def photo
    p = self.photos.first
  end
      
  before_destroy {|record| Photo.destroy_all "photoable_type = 'Place' and photoable_id = #{record.id}"}
  acts_as_commentable

  paginates_per 10

  
  rails_admin do
    label "场所"
    parent "Area"

    field :category do
      label "场所分类"
      searchable true
      inverse_of :places
    end
    
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
      inverse_of :places
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

    field :audit do
      label "审核"
    end
    

  end

end
