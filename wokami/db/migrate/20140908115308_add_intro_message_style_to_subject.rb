class AddIntroMessageStyleToSubject < ActiveRecord::Migration
  def change
  	add_column  :subjects, :intro_message_style, :text
  end
end
