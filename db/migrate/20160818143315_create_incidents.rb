class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.string :slug, null: false
      t.text :description
      t.datetime :start_time
      t.string :location
      t.float :latitude
      t.float :longitude

      t.timestamps
    end

    add_index :incidents, :slug, unique: true
  end
end
