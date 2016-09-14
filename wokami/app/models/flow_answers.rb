#no longer used, belongs to old q&a wokami

class FlowAnswers < ActiveRecord::Base
	self.table_name = "flow_answers"

	belongs_to :flow
	belongs_to :answer
end
