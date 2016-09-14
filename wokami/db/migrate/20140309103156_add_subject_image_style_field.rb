class AddSubjectImageStyleField < ActiveRecord::Migration
  def change
  	add_column :subjects, :image_css, :string
  	
  end
end
