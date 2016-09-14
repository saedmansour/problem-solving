class PostsAddChaptersUsers < ActiveRecord::Migration
  def change
  	add_reference :posts, :user, index: true
  	add_reference :posts, :chapter, index: true
  end
end