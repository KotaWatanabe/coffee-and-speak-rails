class RemoveColumnsFromAvailability < ActiveRecord::Migration[5.2]
  def change
    remove_column :availabilities, :date, :string
    remove_column :availabilities, :start, :string
    remove_column :availabilities, :end, :string
  end
end
