class SearchService

	#
	# Search on multiple Models, right now we only support News for the 
	# sake of example
	#
  def search(query)
    search_news(query)
  end

private

	def search_news(query)
		News.search(query)
	end
end