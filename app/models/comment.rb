class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'
  attr_accessible :title, :comment,:user_id,:commentable_id,:commentable_type
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable
  acts_as_commentable
  # NOTE: Comments belong to a user
  belongs_to :user
end
