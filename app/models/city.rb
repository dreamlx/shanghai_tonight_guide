class City < ActiveRecord::Base
  attr_accessible :city, :province_id
  belongs_to :province
  has_many :areas
end
