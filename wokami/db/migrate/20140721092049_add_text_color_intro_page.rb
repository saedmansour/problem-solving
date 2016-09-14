class AddTextColorIntroPage < ActiveRecord::Migration
  def change
  	add_column  :subjects, :intro_page_titles_color, :string
  end
end
