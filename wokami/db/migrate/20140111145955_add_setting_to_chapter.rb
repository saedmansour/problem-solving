class AddSettingToChapter < ActiveRecord::Migration
  def change
  	add_column :chapters, :chapter_type, :string
  end
end
