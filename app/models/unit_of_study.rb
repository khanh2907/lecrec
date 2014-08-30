class UnitOfStudy < ActiveRecord::Base
  has_many :semesters
  has_and_belongs_to_many :users
  validates :alpha_code, uniqueness: true

  accepts_nested_attributes_for :users

  def number_of_lecture_recordings
    count = 0
    semesters.each do |semester|
      count += semester.lecture_recordings.length
    end
    return count
  end
end
