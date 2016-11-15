class CreateReligions < ActiveRecord::Migration[5.0]
  def change
    create_table :religions do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :religions, :slug, unique: true

    add_reference :users, :religion, foreign_key: true
  end
end
