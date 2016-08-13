class AddUidToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid, :string
    add_index :users, :uid, unique: true

    User.all.find_each do |user|
      user.ensure_uid
      user.save
    end

    change_column :users, :uid, :string, null: false
  end
end
