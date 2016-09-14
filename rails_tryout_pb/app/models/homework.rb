class Homework < ActiveRecord::Base
	self.table_name = "homework"

	has_many :questions
end