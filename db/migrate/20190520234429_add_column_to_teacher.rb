class AddColumnToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :description, :text
  end
end
