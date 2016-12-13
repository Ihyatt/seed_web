class CreateIncidentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :incident_types do |t|
      t.string :name, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :incident_types, :position
  end
end
