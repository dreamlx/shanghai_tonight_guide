# encoding: utf-8
class User < ActiveRecord::Base
  before_update :set_private_token
  has_many :reports
  validates_uniqueness_of :username
  rolify
  
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :token_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable
  
  attr_accessor :login
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email,:avatar,:avatar_cache, :password, 
  :password_confirmation, :remember_me, :authentication_token, 
  :private_token, :favorite_place_ids, :device_token,:login,:mobile
  rails_admin do
    list do 
      field :avatar do 
        label "相片"
      end
      field :name do 
        label "名称"
      end
      field :email do
        label "Email"
      end

    end

  end

  has_many :albums
  # has_and_belongs_to_many :places
  # accepts_nested_attributes_for :places, :allow_destroy => true 
  # attr_accessible :place_ids, :places_attributes
  def update_private_token
    random_key = "#{SecureRandom.hex(10)}:#{self.id}"
    self.update_attribute(:private_token, random_key)
  end 
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(mobile) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  
  private
  
  def set_private_token
    self.ensure_authentication_token!
    self.private_token = self.authentication_token
  end
  
end
