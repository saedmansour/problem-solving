class AddNextQuestionToAnswer < ActiveRecord::Migration
  def change
  	add_column :answers, :next_question_id, :integer
  end
end
