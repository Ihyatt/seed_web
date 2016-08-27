class AddPositionToRace < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :position, :integer, null: false, default: 0
  end
end
