class AddAdminIdToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :admin_id, :integer
    add_index :apps, :admin_id
  end
end
