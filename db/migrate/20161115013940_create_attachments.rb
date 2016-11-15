class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :incident, foreign_key: true, null: false

      t.timestamps
    end
  end
end
