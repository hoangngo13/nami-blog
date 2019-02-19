class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  
  def index
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end
  def new
    @user = User.new
  end

  def show
    @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User created success!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
        flash[:sucess] = "User updated success"
        redirect_to articles_path
    else
        render edit
    end
  end

  def destroy
    @user.destroy
    flash[:danger] = "User and all articles has been deleted success!"
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def find_user
      @user = User.find(params[:id])
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "Could not edit another user's profile"
        redirect_to root_path
      end
    end

    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = "Only admin user can do this!"
        redirect_to root_path
      end
    end
end
