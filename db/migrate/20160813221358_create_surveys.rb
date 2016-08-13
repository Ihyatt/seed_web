class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.references :user, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
