class AddGeneralStyleToSubject < ActiveRecord::Migration
  def change
  	add_column  :subjects, :general_style, :text
  end
end
