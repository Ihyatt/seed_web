class AddCompletedToIncident < ActiveRecord::Migration[5.0]
  def change
    add_column :incidents, :completed, :boolean, default: false, null: false

    add_index :incidents, :completed
  end
end
