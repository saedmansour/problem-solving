class UserAnswers < ActiveRecord::Migration
  def change
  	create_table :users_answers do |t|
    	t.belongs_to :answer, index: true
    	t.belongs_to :user, index: true
    end
  end
end
