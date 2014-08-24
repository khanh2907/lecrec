class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.string :content
      t.integer :lecture_recording_id
      t.integer :user_id

      t.timestamps
    end
  end
end
