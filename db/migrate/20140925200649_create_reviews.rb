class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :title
      t.string :author
      t.string :picture
      t.string :rating
      t.text :comment
      t.string :reader

      t.timestamps
    end
  end
end
