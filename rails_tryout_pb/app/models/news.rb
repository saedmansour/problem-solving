class News < ActiveRecord::Base
	include Searchable

	# TODO?
	# info: http://benjaminknofe.com/blog/2014/06/14/rspec-testing-rails-with-elasticsearch/
	# index name for each env
	# index_name ["Tomodomo", Rails.env, self.base_class.to_s.pluralize.underscore].join('_')
end