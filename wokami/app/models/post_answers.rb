#no longer used, belongs to old q&a wokami

class PostAnswers < ActiveRecord::Base
	self.table_name = "post_answers"

	belongs_to :post
	belongs_to :answer
end
