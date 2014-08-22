class AddProcessedPathToLectureRecordings < ActiveRecord::Migration
  def change
    add_column :lecture_recordings, :processed_path, :string
  end
end
