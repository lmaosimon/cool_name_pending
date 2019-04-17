class AddSectionToRecommendation < ActiveRecord::Migration[5.2]
  def change
    add_column :recommendations, :section, :string
  end
end
