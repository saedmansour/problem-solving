class AddIsNavigationToSubject < ActiveRecord::Migration
  def change
  	add_column  :subjects, :is_navigation, :boolean
  end
end
