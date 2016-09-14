class Chapter < ActiveRecord::Base
	belongs_to :subject
	has_many :posts
	has_many :flows, :through => :flow_chapters

	has_many :flow_chapters
end
