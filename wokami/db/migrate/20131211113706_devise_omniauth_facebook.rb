class DeviseOmniauthFacebook < ActiveRecord::Migration
  def change
   add_column :users, :uid, :integer, :limit => 8
   add_column :users, :profile_image, :string
   add_column :users, :oauth_token, :string
   add_column :users, :oauth_expires_at, :time
   add_column :users, :name, :string
   add_column :users, :username, :string
   add_column :users, :role, :string # not for facebook
   add_column :users, :provider, :string
   
   add_index :users, :uid, :unique => true
  end
end

