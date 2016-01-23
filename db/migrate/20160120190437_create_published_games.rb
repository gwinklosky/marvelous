class CreatePublishedGames < ActiveRecord::Migration
  def change
    create_table :published_games do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.datetime :featured
      t.boolean :current_feature
      t.boolean :active
      t.string :username

      t.timestamps
    end
  end
end
