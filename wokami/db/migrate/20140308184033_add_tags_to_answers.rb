class AddTagsToAnswers < ActiveRecord::Migration
  def change
  	drop_table :answers_tags

  	create_table :answers_tags do |t|
    	t.belongs_to :answer, index: true
    	t.string :tag
    	t.float :weight
    end
  end
end
