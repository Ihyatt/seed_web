class CreateAPIKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.string :read_key, null: false, index: true
      t.string :write_key, null: false, index: true

      t.timestamps
    end
  end
end
