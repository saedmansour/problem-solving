class AddIsSearchToSubject < ActiveRecord::Migration
  def change
  	add_column  :subjects, :is_search, :boolean
  end
end
