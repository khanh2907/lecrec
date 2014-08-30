class ChangeSemsetersUsersColumn < ActiveRecord::Migration
  def change
    rename_column :semesters_users, :semesters_id, :semester_id
  end
end
