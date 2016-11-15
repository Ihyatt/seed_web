class CreateOfficers < ActiveRecord::Migration[5.0]
  def change
    create_table :officers do |t|
      t.references :incident, foreign_key: true, null: false
      t.references :race, foreign_key: true
      t.references :gender, foreign_key: true
      t.string :name
      t.string :badge_number
      t.string :description

      t.timestamps
    end
  end
end
