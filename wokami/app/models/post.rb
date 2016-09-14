class Post < ActiveRecord::Base
	belongs_to :subject
	belongs_to :user
	belongs_to :chapter

	has_and_belongs_to_many :tags

	#acts_as_taggable
	acts_as_votable
	acts_as_commentable
end
