class AddStartAndEndTimeToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :start_time, :boolean
    add_column :courses, :end_time, :boolean
  end
end
