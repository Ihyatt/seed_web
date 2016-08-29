class AddGenderReferenceToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :gender, :string
    add_reference :users, :gender, foreign_key: true

    Gender.seed
  end
end
