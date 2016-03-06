class SubmittedGame < ActiveRecord::Base
  belongs_to :user
  has_one :published_game

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :status, presence: true

  def self.destroy_previous_submissions(user)
    games = SubmittedGame.where(:user_id => user.id)
    games.each {|g| g.destroy}
  end
  
  def publish
    g = PublishedGame.new(:user_id => user_id, :title => title, :description => description, :current_feature => false, :active => true)
    words = PublishedGameWordSet.new(:words => words)
    g.published_game_word_set = words
    if g.save
      user.update_attributes(:published => true) if !user.published  
      update_attributes(:status => "Published", :reason => "Success", :published_game_id => g.id)  
    else
      update_attributes(:status => "Error", :reason => g.errors.full_messages.join(', '))
    end
  end
end
