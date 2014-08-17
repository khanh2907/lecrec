class AddRawVideoToLectureRecordings < ActiveRecord::Migration
  def change
    add_column :lecture_recordings, :raw_video, :string
  end
end
