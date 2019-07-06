class AddColumnsToAvailability < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :mondany, :boolean
    add_column :availabilities, :tuesday, :boolean
    add_column :availabilities, :wednesday, :boolean
    add_column :availabilities, :thursday, :boolean
    add_column :availabilities, :friday, :boolean
    add_column :availabilities, :saturday, :boolean
    add_column :availabilities, :sunday, :boolean
  end
end
