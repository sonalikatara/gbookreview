class AddGroupPassword < ActiveRecord::Migration
  def up
   add_column :groups, :groupPassword, :string
  end

  def down
    remove_column :groups, :groupPassword
  end
end
