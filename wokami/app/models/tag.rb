class Tag < ActiveRecord::Base
	self.table_name = "tags"

	belongs_to :tag_context
	has_and_belongs_to_many :posts
end
