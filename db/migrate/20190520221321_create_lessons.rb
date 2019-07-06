class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.references :user, foreign_key: true
      t.references :teacher, foreign_key: true
      t.references :availability, foreign_key: true
      t.boolean :approved

      t.timestamps
    end
  end
end
