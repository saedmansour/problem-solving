class PointsUserChapter < ActiveRecord::Migration
  def change
  	create_table :points do |t|
      t.belongs_to :user, index: true
      t.belongs_to :chapter, index: true
      t.integer :size, :default => 0
      t.timestamps
    end
  end
end
