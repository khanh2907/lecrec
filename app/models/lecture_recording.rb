class LectureRecording < ActiveRecord::Base
  belongs_to :user
  belongs_to :semester
  has_many :discussions, dependent: :destroy
  validates_presence_of :raw_video, :name
  mount_uploader :raw_video, RawVideoUploader
end
