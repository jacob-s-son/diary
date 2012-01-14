class IndexesForCommonFields < ActiveRecord::Migration
  def up
    add_index :notes, :user_id, :unique => false
    add_index :notes, :id,      :unique => true
  end

  def down
    remove_index :notes, :user_id, :unique => false
    remove_index :notes, :id,      :unique => true
  end
end
