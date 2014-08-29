class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :session
      t.integer :year
      t.integer :unit_of_study_id

      t.timestamps
    end
  end
end
