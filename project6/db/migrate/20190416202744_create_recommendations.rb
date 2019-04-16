class CreateRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :recommendations do |t|
      t.string :name
      t.string :email
      t.string :course

      t.timestamps
    end
  end
end
