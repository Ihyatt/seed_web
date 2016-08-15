class AddPlatformToMessage < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :platform, :string, null: false
  end
end
