class Album < ActiveRecord::Base
  # attr_accessible :title, :body
    attr_accessible :title, :desc, :user_id, :place_id
  has_many :photos
  belongs_to :user
  belongs_to :place
end
