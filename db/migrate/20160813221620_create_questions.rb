class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.references :survey, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
