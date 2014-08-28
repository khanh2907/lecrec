class LectureRecording < ActiveRecord::Base
  belongs_to :user
  has_many :discussions, dependent: :destroy
  validates_presence_of :raw_video, :name
  mount_uploader :raw_video, RawVideoUploader

  def set_success(format, opts)
    p "it worked"
    p '****************'
    p format
    p opts
    p '****************'
  end
end
