class AddAddressFieldsToIncident < ActiveRecord::Migration[5.0]
  def change
    add_column :incidents, :address, :string
  end
end
