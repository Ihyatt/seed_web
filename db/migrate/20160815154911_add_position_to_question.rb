class AddPositionToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :position, :integer, null: false, default: 0
    add_index :questions, :position
  end
end
