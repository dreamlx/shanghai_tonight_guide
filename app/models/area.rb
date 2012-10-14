class Area < ActiveRecord::Base
  attr_accessible :area, :city_id
  belongs_to :city
  has_many :places
end
