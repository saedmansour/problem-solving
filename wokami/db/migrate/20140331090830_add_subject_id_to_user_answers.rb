class AddSubjectIdToUserAnswers < ActiveRecord::Migration
  def change
  		add_column 		:users_answers, :subject_id, :integer
  		add_index 		:users_answers, :subject_id
  end
end
