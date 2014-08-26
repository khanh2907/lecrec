class Discussion < ActiveRecord::Base
  belongs_to :user
  belongs_to :lecture_recording
  has_many :comments, dependent: :destroy
end
