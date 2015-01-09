class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :groupName
      t.string :picture
      t.string :email
      t.string :description
      t.string :password

      t.timestamps
    end
  end
end
