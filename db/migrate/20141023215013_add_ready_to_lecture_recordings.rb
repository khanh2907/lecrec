class AddReadyToLectureRecordings < ActiveRecord::Migration
  def change
    add_column :lecture_recordings, :ready, :boolean, :default => false
  end
end
