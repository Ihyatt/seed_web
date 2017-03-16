class AddPlaceToIncident < ActiveRecord::Migration[5.0]
  def change
    add_reference :incidents, :place, foreign_key: true
  end
end
