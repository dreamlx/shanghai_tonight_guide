class Device < ActiveRecord::Base
  attr_accessible :device_id, :device_token, :badge_count
  validates :device_token, :uniqueness => true
end
