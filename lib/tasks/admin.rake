namespace :admin do
  desc "Make admin"
  task :user => [:environment] do
    if ENV["USER_ID"] && User.exists?(ENV["USER_ID"])
      User.find(ENV["USER_ID"]).make_admin
    else
      puts "Invalid ID"
    end
  end

  desc "List admin"
  task :list => [:environment] do
    User.admins.each do |admin_user|
      puts "#{admin_user.id}:#{admin_user.username} key: #{admin_user.key}"
    end
  end

  desc "List users"
  task :users => [:environment] do
    User.all.each do |user|
      puts "#{user.id}:#{user.username}"
    end
  end

  desc "List games"
  task :games => [:environment] do
    PublishedGame.where(:active => true).each do |g|
      puts "#{g.id}: #{g.title}"
    end
  end

  desc "Publish a game"
  task :publish => [:environment] do
    if ENV["GAME_ID"] && SubmittedGame.exists?(ENV["GAME_ID"])
      SubmittedGame.find(ENV["GAME_ID"]).publish
      puts "published"
    else
      puts "Invalid ID"
    end
  end

  desc "Make game featured"
  task :feature => [:environment] do
    if ENV["GAME_ID"] && PublishedGame.exists?(ENV["GAME_ID"])
      PublishedGame.find(ENV["GAME_ID"]).make_featured
      puts "featured"
    else
      puts "Invalid ID"
    end
  end

  desc "Make game active"
  task :active => [:environment] do
    if ENV["GAME_ID"] && PublishedGame.exists?(ENV["GAME_ID"])
      game = PublishedGame.find(ENV["GAME_ID"])
      game.update_attributes(:active => true)
      game.user.update_attributes(:published => true) if !game.user.published
      puts "activated"
    else
      puts "Invalid ID"
    end
  end

  desc "Inactivate a user and games"
  task :inactivate => [:environment] do
    if ENV["USER_ID"] && User.exists?(ENV["USER_ID"])
      user = User.find(ENV["USER_ID"])
      user.update_attributes(:published => false)
      puts "published set to false"
      user.published_games.each do |g|
        g.update_attributes(:active => false) if g.active
      end 
      puts "inactivated games"
    else
      puts "Invalid ID"
    end
  end

  desc "Remove test user and scores"
  task :remove => [:environment] do
    if ENV["USER_ID"] && User.exists?(ENV["USER_ID"])
      user = User.find(ENV["USER_ID"])
      if user
        User.remove_completely(user)
        puts "completed"
      else
        puts "Invalid ID"
      end
    end
  end

  desc "Set publish on users"
  task :check_publish => [:environment] do
    User.where("published != ?", true).each do |user|
      if !user.published_games.empty?
        puts "user #{user.username} has games"
        user.update(:published => true)
      end
    end
    puts "completed"
  end
  
  desc "Toggle published"
  task :toggle_publish => [:environment] do
    if ENV["USER_ID"] && User.exists?(ENV["USER_ID"])
      user = User.find(ENV["USER_ID"])
      puts "was #{user.published}"
      user.published= !(user.published == true)
      user.save
      puts "toggled to #{user.published}"
    else
      puts "Invalid ID"
    end
  end
  
end