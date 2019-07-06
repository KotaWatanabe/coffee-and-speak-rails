class AddScheduleToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :schedule, :json
  end
end
