# encoding: utf-8
class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'
  attr_accessible :title, :comment,:user_id,:commentable_id,:commentable_type, :recommend, :price,:rating
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
  acts_as_commentable
  # NOTE: Comments belong to a user
  belongs_to :user
  rails_admin do
    list do 
      field :title do 
        label "标题"
      end
      field :comment do 
        label "描叙"
      end
      field :user do
        label "用户"
      end
      field :commentable do
        label "被评论的对象"
      end      
      field :comments do
        label "评论"
      end
    end

  end
end
