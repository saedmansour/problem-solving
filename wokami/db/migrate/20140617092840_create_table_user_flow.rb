class CreateTableUserFlow < ActiveRecord::Migration
  def change
    create_table :user_flows do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :flow, index: true
    end
  end
end
