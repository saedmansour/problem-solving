class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.integer :number
      t.belongs_to :subject

      t.timestamps
    end
  end
end
