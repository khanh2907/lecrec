class ChangeDiscussionContentToText < ActiveRecord::Migration
  def change
    change_column :discussions, :content,  :text
  end
end
