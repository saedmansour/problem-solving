#no longer used, belongs to old q&a wokami

class Question < ActiveRecord::Base
	belongs_to :subject
	has_many :answers
end
