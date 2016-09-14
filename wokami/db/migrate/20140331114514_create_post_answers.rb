class CreatePostAnswers < ActiveRecord::Migration
  def change
  	create_table :post_answers do |t|
    	t.belongs_to :answer, index: true
    	t.belongs_to :post, index: true
    end
  end
end
