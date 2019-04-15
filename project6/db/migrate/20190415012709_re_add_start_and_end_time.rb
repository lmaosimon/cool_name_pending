class ReAddStartAndEndTime < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :start_time, :string
    add_column :courses, :end_time, :string
  end
end
