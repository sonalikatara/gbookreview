class AddAttachmentBookcoverToReviews < ActiveRecord::Migration
  def self.up
    change_table :reviews do |t|
      t.attachment :bookcover
    end
  end

  def self.down
    drop_attached_file :reviews, :bookcover
  end
end
