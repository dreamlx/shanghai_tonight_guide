# encoding: utf-8
class City < ActiveRecord::Base
  attr_accessible :name, :province_id
  belongs_to :province
  has_many :areas
  
  rails_admin do
    list do 
      
      field :name do 
        label "名称"
      end
      
      field :province do 
        label "省份"
      end
      
      field :areas do 
        label "区域"
      end
      
    end  
  end
  
end
