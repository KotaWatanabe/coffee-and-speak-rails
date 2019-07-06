class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.references :teacher, foreign_key: true
      t.string :transaction_id

      t.timestamps
    end
  end
end
