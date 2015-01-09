class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :groups, :password , :password_digest
  end
end
