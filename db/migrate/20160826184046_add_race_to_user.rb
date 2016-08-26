class AddRaceToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :race, foreign_key: true
  end
end
