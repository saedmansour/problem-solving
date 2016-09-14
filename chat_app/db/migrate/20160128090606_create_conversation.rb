class CreateConversation < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
    	t.belongs_to :app 
    	t.integer :client_id
      t.integer :admin_id
      t.timestamps
    end

    add_index :conversations, :app_id
    add_index :conversations, :client_id
    add_index :conversations, :admin_id
  end
end
