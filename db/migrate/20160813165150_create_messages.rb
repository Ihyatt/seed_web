class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :conversation, foreign_key: true, null: false, index: true
      t.references :user, foreign_key: true, null: false, index: true
      t.text :text

      t.timestamps
    end
  end
end
