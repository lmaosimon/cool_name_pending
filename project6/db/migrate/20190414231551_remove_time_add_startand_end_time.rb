class RemoveTimeAddStartandEndTime < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :courses, :time
  end

  def self.down
    add_column :courses, :start_time, boolean
    add_column :courses, :end_time, boolean
  end
end
