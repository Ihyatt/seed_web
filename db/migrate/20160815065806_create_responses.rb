class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.references :question, foreign_key: true, null: false
      t.string :kind, null: false

      t.timestamps
    end
  end
end
