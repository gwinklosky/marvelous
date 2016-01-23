class CreatePublishedGameWordSets < ActiveRecord::Migration
  def change
    create_table :published_game_word_sets do |t|
      t.integer :published_game_id
      t.text :words

      t.timestamps
    end
  end
end
