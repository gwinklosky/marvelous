namespace :admin do
  desc "Make admin"
  task :user => [:environment] do
    if ENV["USER_ID"] && User.exists?(ENV["USER_ID"])
      User.find(ENV["USER_ID"]).make_admin
    else
      puts "Invalid ID"
    end
  end

  desc "Make game featured"
  task :feature => [:environment] do
    if ENV["GAME_ID"] && PublishedGame.exists?(ENV["GAME_ID"])
      PublishedGame.find(ENV["GAME_ID"]).make_featured
    else
      puts "Invalid ID"
    end
  end

  desc "Make a science user and game"
  task :science => [:environment] do
    sci_name = "MrScience"
    mr_science = User.where(:username => sci_name).first
    if mr_science
      puts "User already created"
    else
      mr_science = User.create(:username => sci_name, :key => '123',
        :published => true)
    end
    e_game1 = PublishedGame.create(:user_id => mr_science.id,
      :username => mr_science.username, :title => 'Elements',
      :description => 'Guess the element (symbol clues)')

    PublishedGameWordSet.create(:published_game_id => e_game1.id,
      :words => '["gold:Au", "silver:Ag", "hydrogen:H", "oxygen:O", "iron:Fe", "helium:He", "cloride:Cl", "sodium:Na", "nitrogen:N", "nickle:Ni", "mercury:Hg", "zinc:Zn", "aluminum:Al", "copper:Cu", "potassium:K"]') 
  end

end
