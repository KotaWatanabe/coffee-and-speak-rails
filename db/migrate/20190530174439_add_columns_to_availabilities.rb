class AddColumnsToAvailabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :availabilities, :day, :string
    add_column :availabilities, :morning, :boolean
    add_column :availabilities, :afternoon, :boolean
    add_column :availabilities, :evening, :boolean
  end
end
