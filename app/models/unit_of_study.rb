class UnitOfStudy < ActiveRecord::Base
  has_many :semesters
  has_and_belongs_to_many :users
end
