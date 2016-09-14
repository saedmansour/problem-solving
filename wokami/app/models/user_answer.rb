#no longer used, belongs to old q&a wokami

class UserAnswer < ActiveRecord::Base
	self.table_name = "users_answers"
	belongs_to :user
	belongs_to :answer
end
