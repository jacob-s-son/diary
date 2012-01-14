class RenameContentInNoteToDescription < ActiveRecord::Migration
  def up
    rename_column :notes, :content, :description
  end

  def down
    rename_column :notes, :description, :content
  end
end
