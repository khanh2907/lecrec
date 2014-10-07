json.array!(@videos) do |video|
  json.extract! video, :id, :title, :description, :content_url, :community_id, :user_id
  json.url video_url(video, format: :json)
end
