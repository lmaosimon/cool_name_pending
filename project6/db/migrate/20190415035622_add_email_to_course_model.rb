class AddEmailToCourseModel < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :email, :string
  end
end
