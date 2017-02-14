class AddAgeEstimateToOfficer < ActiveRecord::Migration[5.0]
  def change
    add_column :officers, :age_estimate, :string
  end
end
