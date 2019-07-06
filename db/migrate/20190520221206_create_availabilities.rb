class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.references :teacher, foreign_key: true
      t.string :date
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
