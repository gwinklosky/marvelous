class GamesController < ApplicationController
  before_filter :load_instance, :only => [:show, :edit, :update, :destroy]

  def index
    @games = PublishedGame.all
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
    if @game.update(game_params)
      redirect_to @game
    else
      render 'edit'
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

private
  def load_instance
    @game = PublishedGame.find(params[:id])
  end

  def game_params
    params.require(:published_game).permit(:title, :description, :user_id,
      :active)
  end
end
