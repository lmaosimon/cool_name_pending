class CreateJoinTableGraderApplicationCourse < ActiveRecord::Migration[5.2]
  def change
    create_join_table :grader_applications, :courses do |t|
      # t.index [:grader_application_id, :course_id]
      # t.index [:course_id, :grader_application_id]
    end
  end
end
