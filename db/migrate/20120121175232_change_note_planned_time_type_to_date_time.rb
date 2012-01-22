class ChangeNotePlannedTimeTypeToDateTime < ActiveRecord::Migration
  def up
    change_column :notes, :planned_time, :datetime
  end

  def down
    change_column :notes, :planned_time, :time
  end
end
