class ChangesToNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :lecture_recording_id
    remove_column :notifications, :video_id
    remove_column :notifications, :comment_id
    remove_column :notifications, :discussion_id
    remove_column :notifications, :content
    add_column :notifications, :content, :text
    add_column :notifications, :viewed, :boolean, :default => false
  end
end
