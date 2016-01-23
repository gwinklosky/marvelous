class CreateSubmittedGames < ActiveRecord::Migration
  def change
    create_table :submitted_games do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.text :words
      t.integer :published_game_id
      t.string :status
      t.string :reason

      t.timestamps
    end
  end
end
