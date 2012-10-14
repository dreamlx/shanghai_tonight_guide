class Province < ActiveRecord::Base
  attr_accessible :province
  has_many :cities
end
