# coding: utf-8
class Province < ActiveRecord::Base
  attr_accessible :name
  has_many :cities
  rails_admin do
    list do 
      field :name do 
        label "名称"
      end
      field :cities do 
        label "城市"
      end
    end  
  end
end
