#no longer used, belongs to old q&a wokami

class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :next_question, :class_name => "Question"
end
