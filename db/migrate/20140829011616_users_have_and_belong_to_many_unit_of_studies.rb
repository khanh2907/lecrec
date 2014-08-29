class UsersHaveAndBelongToManyUnitOfStudies < ActiveRecord::Migration
  def self.up
    create_table :unit_of_studies_users, :id => false do |t|
      t.references :unit_of_study, :user
    end
  end

  def self.down
    drop_table :unit_of_studies_users
  end
end
