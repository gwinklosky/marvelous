class User < ActiveRecord::Base
  has_many :published_games
  has_many :submitted_games
  has_many :published_game_scores

  validates :username, uniqueness: true
  validates :key, presence: true
  
  def make_admin
    update_attribute(:admin, true) if !admin
  end
  
  def clense_username
    update_attribute(:username, "PeaceLoveJoy#{id}")
    published_games.each {|pg| pg.update_attribute(:username, username)}
    published_game_scores.each {|pgs| pgs.update_attribute(:username, username)}
  end
  
  def self.admins
    User.where(:admin => true).order("username asc")
  end

  def has_game(game)
    !(published_game_scores.detect {|gs| gs.published_game_id == game.id}).nil?
  end

  def self.remove_completely(user)
    if user.published_games.empty?
      user.submitted_games.each {|sg| sg.destroy}
      user.published_game_scores.each {|gs| gs.destroy}
      user.destroy
    else
      put "unable to delete published user #{user.username}"
    end
  end
end
