class TagContext < ActiveRecord::Base
	self.table_name = "tag_context"

	belongs_to :subject
	has_many :tags
end
