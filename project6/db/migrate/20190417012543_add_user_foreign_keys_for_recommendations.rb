class AddUserForeignKeysForRecommendations < ActiveRecord::Migration[5.2]
  def change
    add_reference :recommendations, :user, index: true
  end
end
