class AddAssignmentToGraderApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :grader_applications, :assignment, :string
  end
end
