json.array!(@answers) do |answer|
  json.extract! answer, :content, :question_id, :weight, :next_question_id
  json.url answer_url(answer, format: :json)
end
