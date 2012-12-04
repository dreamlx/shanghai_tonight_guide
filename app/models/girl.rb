# encoding: utf-8
class Girl < ActiveRecord::Base
  attr_accessible :age, :desc, :livein, :name
  rails_admin do
    list do 
      field :name do 
        label "姓名"
      end
      field :age do 
        label "年龄"
      end      
      field :desc do 
        label "描叙"
      end
      field :livein do
        label "居住地"
      end

    end

  end  
end
