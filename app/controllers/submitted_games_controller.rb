class SubmittedGamesController < ApplicationController
  before_filter :load_instance, :only => [:words, :show, :edit, :update, :destroy, :publish]

  def index
    @submitted_games = SubmittedGame.all
  end

  def submitted
    limit_to = params[:limit] ? params[:limit].to_i : 200 
    @submitted_games = SubmittedGame.where(:status => "Submitted").order("updated_at asc").limit(limit_to)
    render :index
  end
  
  def new
    @submitted_game = SubmittedGame.new
  end
  
  def create
    success = false
    users = User.where(user_params)
    @submitted_game = SubmittedGame.new(submitted_game_params)
    if !users.empty?
      SubmittedGame.destroy_previous_submissions(users.first)
      @submitted_game.status = "Submitted"
      @submitted_game.reason = "" if @submitted_game.reason.nil?
      if !(success = @submitted_game.save)
        @submitted_game.status = "Error"
        @submitted_game.reason = @submitted_game.errors.full_messages.join(', ')
      end
    else
      @submitted_game.status = "Error"
      @submitted_game.reason = "Unauthorized" 
    end      
    render (success ? :show : :new)
  end
  
  def show
  end

  def edit
  end

  def update
    users = User.where(user_params.merge(:admin => true))
    if !users.empty?
      if @submitted_game.update(submitted_game_params)
        redirect_to @submitted_game
      else
        render 'edit'
      end
    else
      render '/games/invalid_id'      
    end
  end

  def destroy
    users = User.where(user_params.merge(:admin => true))
    if !users.empty?
      @submitted_game.destroy
    end
    redirect_to submitted_games_path
  end

  def publish
    users = User.where(user_params.merge(:admin => true))
    if !users.empty?
      @submitted_game.publish
    end
    render :show
  end
private
  def load_instance
    @submitted_game = SubmittedGame.find(params[:id])
  end

  def submitted_game_params
    params.require(:submitted_game).permit(:title, :description, :user_id,
      :words, :status, :reason)
  end
  def user_params
    params.require(:user).permit(:id, :key)
  end
end
