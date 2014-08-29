class Semester < ActiveRecord::Base
  belongs_to :unit_of_study
  has_and_belongs_to_many :users
  has_many :lecture_recordings
end
