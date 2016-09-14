class UrlFromStringToText < ActiveRecord::Migration
  def change
  	change_column :posts, :url, :text
  	change_column :posts, :image, :text
  end
end
