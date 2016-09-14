json.array!(@answer_tags) do |answer_tag|
  json.extract! answer_tag, :answer_id, :tag, :weight
  json.url answer_tag_url(answer_tag, format: :json)
end
