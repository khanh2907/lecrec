json.array!(@semesters) do |semester|
  json.extract! semester, :id, :session, :year, :unit_of_study_id
  json.url semester_url(semester, format: :json)
end
