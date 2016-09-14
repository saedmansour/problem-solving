class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :sender_id, index: true
      t.belongs_to :conversation, index: true
    end
  end
end
