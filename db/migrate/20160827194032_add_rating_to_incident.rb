class AddRatingToIncident < ActiveRecord::Migration[5.0]
  def change
    add_column :incidents, :rating, :integer
  end
end
