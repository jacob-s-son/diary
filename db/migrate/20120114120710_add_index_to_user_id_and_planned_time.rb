class AddIndexToUserIdAndPlannedTime < ActiveRecord::Migration
  def change
    add_index :notes, [:user_id, :planned_time]
  end
end
