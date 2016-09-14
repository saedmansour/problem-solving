class AddTypeToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :subject_type, :string
  end
end
