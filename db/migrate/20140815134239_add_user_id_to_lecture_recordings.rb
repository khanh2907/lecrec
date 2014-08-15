class AddUserIdToLectureRecordings < ActiveRecord::Migration
  def change
    add_column :lecture_recordings, :user_id, :integer
  end
end
