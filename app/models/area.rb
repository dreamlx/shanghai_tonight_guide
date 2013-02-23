# encoding: utf-8
class Area < ActiveRecord::Base
  attr_accessible :name, :city_id
  belongs_to :city
  has_many :places,:inverse_of => :area, :dependent => :destroy
  
  # for a nested form:
  accepts_nested_attributes_for :places, :allow_destroy => true
  attr_accessible :places_attributes, :allow_destroy => true
  

  rails_admin do
    parent "City"
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
