class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :points
      #t.integer :subject_id
      t.belongs_to :subject

      t.timestamps
    end
  end
end
