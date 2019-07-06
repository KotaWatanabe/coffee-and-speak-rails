class AddAasmStateToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :aasm_state, :string
  end
end
