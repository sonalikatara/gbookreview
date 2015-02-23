class AddAttachmentGrouppictureToGroups < ActiveRecord::Migration
  def self.up
    change_table :groups do |t|
      t.attachment :grouppicture
    end
  end

  def self.down
    remove_attachment :groups, :grouppicture
  end
end
