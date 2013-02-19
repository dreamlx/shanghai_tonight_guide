class Report < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  validates_presence_of :place_id, :user_id
  attr_accessible :body, :place_id, :title, :user_id
end
