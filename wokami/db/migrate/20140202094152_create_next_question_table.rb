class CreateNextQuestionTable < ActiveRecord::Migration
  def change
    create_table :next_question do |t|
    	t.belongs_to 	:question, index: true
    	t.belongs_to 	:answer, index: true
    	t.integer 		:next_question_id
    end

    add_column :subjects, :root_question_id, :integer
  end
end
