class AddFacebookIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :facebook_id, :string

    add_index :users, :facebook_id, unique: true
  end
end
