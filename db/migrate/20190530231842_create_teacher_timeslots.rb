class CreateTeacherTimeslots < ActiveRecord::Migration[5.2]
  def change
    create_table :teacher_timeslots do |t|
      t.references :teacher, foreign_key: true
      t.references :timeslot, foreign_key: true

      t.timestamps
    end
  end
end
