class AddUserForeignKeysForCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :user, index: true
  end
end
