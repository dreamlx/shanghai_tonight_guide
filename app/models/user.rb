class User < ActiveRecord::Base
  before_update :set_private_token
  rolify
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email,:avatar,:avatar_cache, :password, :password_confirmation, :remember_me, :authentication_token, :private_token, :favorite_place_ids 
  
  # rails_admin do
  #   list do 
  #     field :avatar do 
  #       label "Photo"
  #     end
  #     field :name do 
  #       label "Name"
  #     end
  #     field :email do
  #       label "Email"
  #     end

  #   end

  # end

  has_many :albums
  # has_and_belongs_to_many :places
  # accepts_nested_attributes_for :places, :allow_destroy => true 
  # attr_accessible :place_ids, :places_attributes
  def update_private_token
    random_key = "#{SecureRandom.hex(10)}:#{self.id}"
    self.update_attribute(:private_token, random_key)
  end 
  
  private
  
  def set_private_token
    self.ensure_authentication_token!
    self.private_token = self.authentication_token
  end
  
end
