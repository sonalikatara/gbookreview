class RemoveReaderFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :reader, :string
  end
end
