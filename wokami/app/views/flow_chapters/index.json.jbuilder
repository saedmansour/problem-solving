json.array!(@flow_chapters) do |flow_chapter|
  json.extract! flow_chapter, :flow_id, :chapter_id
  json.url flow_chapter_url(flow_chapter, format: :json)
end
