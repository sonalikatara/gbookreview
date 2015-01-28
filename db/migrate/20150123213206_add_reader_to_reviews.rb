class AddReaderToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :reader, index: true
  end
end
