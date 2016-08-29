class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.string :name, null: false
      t.boolean :positive, null: false, default: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :reactions, :name, unique: true
  end
end
