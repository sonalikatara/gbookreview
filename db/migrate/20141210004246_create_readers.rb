class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :readerName
      t.string :picture
      t.string :email
      t.references :group

      t.timestamps
    end
  end
end
