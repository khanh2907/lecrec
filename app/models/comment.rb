class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  has_and_belongs_to_many :users_liked, :class_name => "User", :join_table => :users_like_comments
end
