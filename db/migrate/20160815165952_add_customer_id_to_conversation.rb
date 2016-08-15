class AddCustomerIdToConversation < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :customer_id, :integer, null: false
    add_index :conversations, :customer_id, unique: true
  end
end
