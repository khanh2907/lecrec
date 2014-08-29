json.array!(@unit_of_studies) do |unit_of_study|
  json.extract! unit_of_study, :id, :title, :alpha_code, :description
  json.url unit_of_study_url(unit_of_study, format: :json)
end
