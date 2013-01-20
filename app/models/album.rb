# encoding: utf-8
class Album < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :desc, :user_id
  has_many :photos,:as=>:photoable
  belongs_to :user

  rails_admin do
    parent "Photo"
    label "用户相册"
    list do 
      field :title do 
        label "标题"
      end
      field :desc do 
        label "描叙"
      end
      field :user do
        label "用户"
      end
      field :photos do
        label "相片"
      end
    end

  end
end
