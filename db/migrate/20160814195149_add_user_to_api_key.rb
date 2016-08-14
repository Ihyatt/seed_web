class AddUserToAPIKey < ActiveRecord::Migration[5.0]
  def change
    add_reference :api_keys, :user, foreign_key: true, null: false
  end
end
