class Flow < ActiveRecord::Base
	belongs_to :subject
	has_many :chapters, :through => :flow_chapters
	has_many :flow_chapters
end
