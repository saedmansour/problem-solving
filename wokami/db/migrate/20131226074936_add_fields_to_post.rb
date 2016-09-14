class AddFieldsToPost < ActiveRecord::Migration
  def change
  	add_column :posts, :minutes, :string
  	add_column :posts, :media_type, :string
  	add_column :posts, :user, :string
  	add_column :posts, :tags, :string
  end
end
