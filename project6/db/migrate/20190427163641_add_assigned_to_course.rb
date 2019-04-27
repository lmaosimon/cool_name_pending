class AddAssignedToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :assigned, :boolean, default: false
  end
end
