class Discussion < ActiveRecord::Base
  belongs_to :user
  belongs_to :lecture_recording
  belongs_to :video
  has_many :comments, dependent: :destroy
end
