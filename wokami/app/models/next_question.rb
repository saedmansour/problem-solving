#no longer used, belongs to old q&a wokami

class NextQuestion < ActiveRecord::Base
	self.table_name = "next_question"

	belongs_to :question
	belongs_to :answer
end
