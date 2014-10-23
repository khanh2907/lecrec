class VideoConverter
  @queue = :convert

  def self.perform(lecrec_id)
    lecrec = LectureRecording.find(lecrec_id)
    p lecrec
    raw_video_path = lecrec.raw_video.current_path
    movie = FFMPEG::Movie.new(raw_video_path)
    if movie.valid?
      dir = File.dirname(raw_video_path)
      ext = File.extname(raw_video_path)
      basename = File.basename(raw_video_path, ext)
      processed_path = "#{dir}/#{basename}.mp4"

      movie.transcode(processed_path) { |progress| puts progress }

      processed_url = lecrec.raw_video.url.gsub(ext, '.mp4')
      lecrec.processed_path = processed_url
      lecrec.ready = true
      lecrec.save!
    end
  end
end