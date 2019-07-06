class AddCommentFieldToLessons < ActiveRecord::Migration[5.2]
  def change
    add_column :lessons, :comment, :text
  end
end
