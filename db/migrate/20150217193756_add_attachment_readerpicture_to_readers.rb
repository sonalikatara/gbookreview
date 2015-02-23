class AddAttachmentReaderpictureToReaders < ActiveRecord::Migration
  def self.up
    change_table :readers do |t|
      t.attachment :readerpicture
    end
  end

  def self.down
    remove_attachment :readers, :readerpicture
  end
end
