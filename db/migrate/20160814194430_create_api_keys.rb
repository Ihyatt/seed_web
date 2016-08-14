class CreateAPIKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.string :read_key, null: false
      t.string :write_key, null: false

      t.timestamps
    end

    add_index :api_keys, :read_key, unique: true
    add_index :api_keys, :write_key, unique: true
  end
end
