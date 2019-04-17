class AddCourseForeignKeyForGraderApplication < ActiveRecord::Migration[5.2]
  def change
    add_reference :grader_applications, :courses, index: true
  end
end
