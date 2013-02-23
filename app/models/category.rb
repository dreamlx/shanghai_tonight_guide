# encoding: utf-8
class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :places,:inverse_of => :category, :dependent => :destroy
  
  # for a nested form:
  accepts_nested_attributes_for :places, :allow_destroy => true
  attr_accessible :places_attributes, :allow_destroy => true
  
  rails_admin do
    parent "Area"
    label "分类"
    list do 
      field :name do 
        label "名称"
      end
      field :places do 
        label "场所"
      end
    end  
  end
end
