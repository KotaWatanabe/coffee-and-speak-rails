class AddLessonRefToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :lesson, foreign_key: true
  end
end
