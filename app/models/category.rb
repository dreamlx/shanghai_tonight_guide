# encoding: utf-8
class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :places
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
