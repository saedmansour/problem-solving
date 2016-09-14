class CreateQuestionsTable < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.string 			:content
    	t.boolean 		:is_multi
    	t.belongs_to 	:subject, index: true
    	t.float 			:weight, :default => 1.0
    end

    create_table :answers do |t|
    	t.string 			:content
    	t.belongs_to 	:question, index: true
    	t.float 			:weight, :default => 1.0
    end

    create_table :answers_tags do |t|
    	t.belongs_to 	:answer, index: true
    	t.belongs_to 	:tag, index: true
    	t.float 			:weight, :default => 1.0
    end

    create_table :flows do |t|
    	t.belongs_to 	:subject, index: true
    	t.integer 		:score, :default => 1
    end

    create_table :flows_tags do |t|
    	t.belongs_to 	:flows, index: true
    	t.belongs_to :tag, index: true
    	t.float :weight, :default => 1.0
    end
  end
end
