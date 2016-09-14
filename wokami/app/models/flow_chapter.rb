class FlowChapter < ActiveRecord::Base
	self.table_name = "flow_chapters"

	belongs_to :flow
	belongs_to :chapter
end
