class AddSectionToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :section, :string
  end
end
