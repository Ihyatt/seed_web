class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :incident, foreign_key: true, null: false
      t.string  :asset_uid
      t.string  :asset_name
      t.integer :asset_width
      t.integer :asset_height
      t.timestamps
    end
  end
end
