class RenameMondanyColumnToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    rename_column :availabilities, :mondany, :monday
  end
end
