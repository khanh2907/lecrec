json.array!(@lecture_recordings) do |lecture_recording|
  json.extract! lecture_recording, :id, :name
  json.url lecture_recording_url(lecture_recording, format: :json)
end
