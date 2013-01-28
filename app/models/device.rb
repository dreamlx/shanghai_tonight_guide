class Device < ActiveRecord::Base
  attr_accessible :device_id, :device_token
  validates :device_token, :uniqueness => true
end
