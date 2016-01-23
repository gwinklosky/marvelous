class User < ActiveRecord::Base
  has_many :published_games
  has_many :submitted_games

  validates :username, uniqueness: true
  validates :key, presence: true
  
  def make_admin
    update_attribute(:admin, true) if !admin
  end
end
