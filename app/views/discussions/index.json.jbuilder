json.array!(@discussions) do |discussion|
  json.extract! discussion, :id, :title, :content, :lecture_recording_id, :user_id
  json.url discussion_url(discussion, format: :json)
end
