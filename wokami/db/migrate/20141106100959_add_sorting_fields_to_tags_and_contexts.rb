class AddSortingFieldsToTagsAndContexts < ActiveRecord::Migration
  def change
  	add_column  :tags, :points, :integer
  	add_column  :tag_context, :points, :integer
  end
end
