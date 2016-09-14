class Flows < ActiveRecord::Migration
  def change
  	add_column 		:flows, :name, :string

  	create_table :flow_answers do |t|
    	t.belongs_to :answer, index: true
    	t.belongs_to :flow, index: true
    end

    create_table :flow_chapters do |t|
    	t.belongs_to :flow, index: true
    	t.belongs_to :chapter, index: true
    	t.integer :order
    end
  end
end
