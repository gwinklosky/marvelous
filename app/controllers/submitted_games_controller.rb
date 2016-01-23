class SubmittedGamesController < ApplicationController
  before_filter :load_instance, :only => [:show, :edit, :update, :destroy, :publish]

  def index
    @submitted_games = SubmittedGame.all
  end
  
  def new
    @submitted_game = SubmittedGame.new
  end
  
  def create
    @submitted_game = SubmittedGame.new(submitted_game_params)
    @submitted_game.save
    redirect_to @submitted_game
  end
  
  def show
  end

  def edit
  end

  def update
    if @submitted_game.update(submitted_game_params)
      redirect_to @submitted_game
    else
      render 'edit'
    end
  end

  def destroy
    @submitted_game.destroy
    redirect_to submitted_games_path
  end

  def publish
    # make a PublishedGame
  end
private
  def load_instance
    @submitted_game = SubmittedGame.find(params[:id])
  end

  def submitted_game_params
    params.require(:submitted_game).permit(:title, :description, :user_id,
      :words, :status, :reason)
  end
end
