class AddAttachmentAssetToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :asset
    end
  end

  def self.down
    remove_attachment :attachments, :asset
  end
end
