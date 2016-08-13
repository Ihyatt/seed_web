class AddGenderToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :locale, :string
    add_column :users, :timezone, :string
    add_column :users, :gender, :string
  end
end
