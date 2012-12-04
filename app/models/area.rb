# encoding: utf-8
class Area < ActiveRecord::Base
  attr_accessible :name, :city_id
  belongs_to :city
  has_many :places

  rails_admin do
    list do 
      field :name do 
        label "名称"
      end
      field :city do 
        label "城市"
      end
      field :places do 
        label "场所"
      end
    end  
  end
end
