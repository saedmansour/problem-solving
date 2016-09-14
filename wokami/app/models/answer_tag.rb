#no longer used, belongs to old q&a wokami

class AnswerTag < ActiveRecord::Base
	self.table_name = "answers_tags"
	belongs_to :answer
end
