json.array!(@posts) do |post|
  json.extract! post, :title, :points, :url, :image, :subject_id
  json.url post_url(post, format: :json)
end
