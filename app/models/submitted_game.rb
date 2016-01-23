class SubmittedGame < ActiveRecord::Base
  belongs_to :user
  has_one :published_game
end
