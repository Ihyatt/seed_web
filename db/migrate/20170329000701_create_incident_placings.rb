class CreateIncidentPlacings < ActiveRecord::Migration[5.0]
  def change
    create_table :incident_placings do |t|
      t.references :incident, foreign_key: true, null: false, index: true
      t.references :place, foreign_key: true, null: false, index: true

      t.timestamps
    end

    add_index :incident_placings, [:incident_id, :place_id], unique: true
  end
end
