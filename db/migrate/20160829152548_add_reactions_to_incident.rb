class AddReactionsToIncident < ActiveRecord::Migration[5.0]
  def change
    add_column :incidents, :reactions, :string, array: true, default: []
    add_index  :incidents, :reactions, using: 'gin'
  end
end