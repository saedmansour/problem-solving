class AddContentCssClassesToPost < ActiveRecord::Migration
  def change
  	  	add_column  :posts, :content_css_classes, :string
  end
end
