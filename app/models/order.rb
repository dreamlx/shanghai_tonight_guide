class Order < ActiveRecord::Base
  belongs_to :place
  validates_presence_of :place_id
  attr_accessible :description, :phone, :place_id, :user_name
end
