class CreateGraderApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :grader_applications do |t|
      t.string :name
      t.string :email
      t.string :qualifications

      t.timestamps
    end
  end
end
