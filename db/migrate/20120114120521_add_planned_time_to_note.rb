class AddPlannedTimeToNote < ActiveRecord::Migration
  def change
    add_column :notes, :planned_time, :datetime
  end
end
