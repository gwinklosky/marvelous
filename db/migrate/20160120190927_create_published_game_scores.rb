class CreatePublishedGameScores < ActiveRecord::Migration
  def change
    create_table :published_game_scores do |t|
      t.integer :published_game_id
      t.integer :user_id
      t.string :username
      t.integer :points

      t.timestamps
    end
  end
end
