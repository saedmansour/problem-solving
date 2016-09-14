json.array!(@subjects) do |subject|
  json.extract! subject, :name, :short_name, :description, :root_question_id
  json.url subject_url(subject, format: :json)
end
