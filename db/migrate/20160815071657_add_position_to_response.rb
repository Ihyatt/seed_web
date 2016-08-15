class AddPositionToResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :position, :integer, null: false, default: 0
    add_column :responses, :placeholder, :string

    add_index :responses, :position
  end
end
