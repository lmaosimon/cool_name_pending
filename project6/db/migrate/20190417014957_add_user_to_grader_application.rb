class AddUserToGraderApplication < ActiveRecord::Migration[5.2]
  def change
    add_reference :grader_applications, :user, index: true
  end
end
