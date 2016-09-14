class AddImageStyleAndDetailsToTablePosts < ActiveRecord::Migration
  def change
  	add_column  :posts, :details, :text
  	add_column  :posts, :image_style, :string
  end
end
