class AddSemesterIdToLectureRecordings < ActiveRecord::Migration
  def change
    add_column :lecture_recordings, :semester_id, :integer
  end
end
