class NewsSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :url

  def url
  	"blog/news/#{self.id}"
  end
end
