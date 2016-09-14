class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :role
      t.belongs_to :app # for admin role

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :role
    add_index :users, :app_id
  end
end
