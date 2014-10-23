class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :lecture_recording_id
      t.integer :video_id
      t.integer :discussion_id
      t.integer :comment_id
      t.string :content

      t.timestamps
    end
  end
end
