class PublishedGame < ActiveRecord::Base
  belongs_to :user
  
  def self.featured
    self.where(:current_feature => true).first
  end

  def make_featured
    old = PublishedGame.featured
    if old
      return if old.id = self.id
      old.update_attributes(:current_feature => false)
    end
    self.update_attributes(:active => true, :current_feature => true, :featured => DateTime.now)
  end
end
