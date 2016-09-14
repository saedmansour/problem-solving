class AddBackgroundColorToSubject < ActiveRecord::Migration
  def change
  	add_column  :subjects, :background_color, :string
  end
end
