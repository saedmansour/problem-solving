json.array!(@chapters) do |chapter|
  json.extract! chapter, :name, :number, :subject_id
  json.url chapter_url(chapter, format: :json)
end
