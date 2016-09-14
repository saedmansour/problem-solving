class SearchTagsTables < ActiveRecord::Migration
  def change
  
    create_table :tag_context do |t|
    	t.belongs_to :subject, index: true
    	t.string :name, index:true
    	t.timestamps
    end

    create_table :posts_tags do |t|
    	t.belongs_to :tag, index: true
    	t.belongs_to :post, index: true
      t.timestamps
    end

    remove_column  :posts, :tags
  end
end
