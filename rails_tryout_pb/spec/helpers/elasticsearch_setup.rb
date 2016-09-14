module ElasticsearchSetup
	def self.before
    News.__elasticsearch__.create_index! index: "news"
    News.create(title: "hello", content: "content")
    News.import
    sleep 1
  end

  def self.after
    News.__elasticsearch__.client.indices.delete index: News.index_name  
  end
end