class RemoveStartAndEndTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :courses, :start_time
    remove_column :courses, :end_time
  end
end
