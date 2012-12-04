# encoding: utf-8
class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  belongs_to :resource, :polymorphic => true
  rails_admin do
    list do 
      field :name do 
        label "名称"
      end
      field :users do 
        label "用户"
      end
    end  
  end  
end
