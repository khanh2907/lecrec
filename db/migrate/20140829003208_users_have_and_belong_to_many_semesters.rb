class UsersHaveAndBelongToManySemesters < ActiveRecord::Migration
  def self.up
    create_table :semesters_users, :id => false do |t|
      t.references :semesters, :user
    end
  end

  def self.down
    drop_table :semesters_users
  end
end
