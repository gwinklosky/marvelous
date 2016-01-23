class UsersController < ApplicationController
  before_filter :load_instance, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end
  
  def published
    @users = User.where(:published => true)
    render :index
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    render (@user.save ? :show : :new)
  end
  
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

def destroy
  @user.destroy
 
  redirect_to users_path
end

private
  def load_instance
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :key, :admin)
  end
end
