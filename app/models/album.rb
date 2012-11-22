class Album < ActiveRecord::Base
  # attr_accessible :title, :body
    attr_accessible :title, :desc, :user_id
  has_many :photos,:as=>:photoable
  belongs_to :user
  #belongs_to :place
end
