class PublishedGame < ActiveRecord::Base
  belongs_to :user
  has_one :published_game_word_set

  def self.featured
    self.where(:current_feature => true).first
  end

  def make_featured
    old = PublishedGame.featured
    if old
      puts "old featured game #{old.title}"
      return if old.id == self.id
      puts "setting old to not featured"
      old.update(:current_feature => false)
    end
    puts "setting #{title} to featured"
    self.update(:active => true, :current_feature => true, :featured => DateTime.now)
  end
  
  def word_list
    published_game_word_set.words
  end
end
