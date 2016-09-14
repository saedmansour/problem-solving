class AddUserIdToFlow < ActiveRecord::Migration
  def change
  	add_column  :flows, :user_id, :integer
  end
end
