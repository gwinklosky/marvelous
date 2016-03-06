class UsersController < ApplicationController
  before_filter :load_instance, :only => [:show, :edit, :update, :clense, :destroy]

  def index
    limit_to = params[:limit] ? params[:limit].to_i : 200 
    @users = User.all.order("updated_at desc").limit(limit_to)
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

  def clense
    users = User.where(admin_params.merge(:admin => true))
    if !users.empty?
      @user.clense_username
    end
    render 'show'
  end

  def update
    users = User.where(admin_params.merge(:admin => true))
    if !users.empty?  
      if @user.update(user_params)
        redirect_to @user
      else
        render 'edit'
      end
    else
      render '/games/invalid_id'
    end
  end

  def destroy
    users = User.where(admin_params.merge(:admin => true))
    if !users.empty?  
      @user.destroy
      redirect_to users_path
    else
      render '/games/invalid_id'
    end
  end

private
  def load_instance
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :key)
  end
  
  def admin_params
    params.require(:admin).permit(:id, :key)
  end
end
