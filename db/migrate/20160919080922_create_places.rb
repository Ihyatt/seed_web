class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.string :short
      t.string :level, null: false, index: true
      t.integer :parent_id, index: true
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    
    add_index :places, :slug, unique: true
  end
end
