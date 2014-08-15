class CreateLectureRecordings < ActiveRecord::Migration
  def change
    create_table :lecture_recordings do |t|
      t.string :name

      t.timestamps
    end
  end
end
