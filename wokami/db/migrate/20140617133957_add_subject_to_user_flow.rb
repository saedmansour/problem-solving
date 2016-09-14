class AddSubjectToUserFlow < ActiveRecord::Migration
  def change
  	add_column  :user_flows, :subject_id, :integer
  end
end
