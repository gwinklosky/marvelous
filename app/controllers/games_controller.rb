class GamesController < ApplicationController
  before_filter :load_instance, :only => [:show, :edit, :update]

  def index
    @games = PublishedGame.all
  end

  def published
    @games = PublishedGame.where(:active => true, :user_id => params[:id])
    render :index
  end

  def featured
    @game = PublishedGame.featured
    render( @game ? :show : :invalid_id)
  end
  
  def show
  end

  def edit
  end

  def update
    users = User.where(user_params.merge(:admin => true))
    if !users.empty?
      if @game.update(game_params)
        redirect_to @game
      else
        render 'edit'
      end
    else
      render '/games/invalid_id'
    end
  end

  def show_words
    @word_sets = PublishedGameWordSet.where(:published_game_id => params[:id])
    @words  = @word_sets.empty? ? nil : @word_sets.first 
  end

  def top_scores
    @user_scores = PublishedGameScore.where(:published_game_id => 0).order("points desc").limit(10)
    @game_scores = PublishedGameScore.includes(:published_game).where("published_game_id > 0").order("points desc").limit(10)
    
    @game = PublishedGame.featured
    @feature_scores = PublishedGameScore.where(:published_game_id => @game.id).order("points desc").limit(10)    
  end

  def game_status
    @user_status = "#{User.count} users"
    @submission_status = "#{SubmittedGame.where(:status => "Submitted").count} submissions to review"
    @game_status = "#{PublishedGame.where(:active => true).count} active games"
  end

  def share_scores
    success = false
    users = User.where(user_params)
    if !users.empty?
      user = users.first
      map_games = {}
      user.published_game_scores.each do |gs|
        map_games[gs.published_game_id] = gs
      end
      
      params[:scores].each do |k,v|
        puts "received score #{v} for id #{k}"
        g_id = k.to_i
        points = v.to_i
        if (gs = map_games[g_id])
          gs.update_attribute(:points, points) if points > gs.points
        else
          gs = PublishedGameScore.create(:user_id => user.id,
            :username => user.username, :published_game_id => g_id, :points => points)
        end 
      end
      @result = "Received" 
    else
      @result = "Error: Unauthorized" 
    end
    render :result
  end
private
  def load_instance
    @game = PublishedGame.find(params[:id])
  end

  def game_params
    params.require(:published_game).permit(:title, :description, :user_id,
      :active)
  end
  def user_params
    params.require(:user).permit(:username, :key, :admin)
  end
  
end
