class LectureRecording < ActiveRecord::Base
  belongs_to :user
  has_many :discussions, dependent: :destroy
  validates_presence_of :raw_video, :name
  mount_uploader :raw_video, RawVideoUploader
end
