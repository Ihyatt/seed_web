class AddMetadataToIncident < ActiveRecord::Migration[5.0]
  def change
    add_column :incidents, :metadata, :jsonb, default: {}
  end
end
