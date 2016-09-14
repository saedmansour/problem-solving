class CreateHomeworkRelatedTables < ActiveRecord::Migration
  def change
    
    create_table :homework do |t|
      t.string :title
    end

    create_table :questions do |t|
    	t.belongs_to :homework
    	t.references :answer
    	t.text :content
    end

    create_table :answers do |t|
    	t.belongs_to :question
    	t.text :content
    end
  
  end
end
