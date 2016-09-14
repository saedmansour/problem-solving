class AddSettingsToSubjects < ActiveRecord::Migration
  def change
  	add_column :subjects, :setting_is_chapters, :boolean
  	add_column :subjects, :setting_is_tags, :boolean
  	add_column :subjects, :setting_is_resources, :boolean
  	add_column :subjects, :setting_is_private, :boolean
  end
end
