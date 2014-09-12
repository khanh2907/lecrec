class AddUsersLikeCommentsTable < ActiveRecord::Migration
  def self.up
    create_table :users_like_comments, :id => false do |t|
      t.references :user, :comment
    end
  end

  def self.down
    drop_table :users_like_comments
  end
end
