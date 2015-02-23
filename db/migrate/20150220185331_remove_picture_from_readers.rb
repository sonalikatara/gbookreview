class RemovePictureFromReaders < ActiveRecord::Migration
  def change
    remove_column :readers, :picture, :string
  end
end
