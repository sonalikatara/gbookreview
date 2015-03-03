class RenameColumninTableReview < ActiveRecord::Migration
  def change
     rename_column :reviews, :picture, :category
  end
end
