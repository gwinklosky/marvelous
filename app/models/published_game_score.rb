class PublishedGameScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :published_game
  validates :user_id, presence: true
  validates :username, presence: true
  validates :points, presence: true

  validates :published_game_id, uniqueness: { scope: :user_id,
    message: "one score per user per game" }

end
