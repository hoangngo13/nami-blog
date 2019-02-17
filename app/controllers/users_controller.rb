class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  
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
        flash[:sucess] = "User created success!"
        redirect_to articles_path
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
  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def find_user
      @user = User.find(params[:id])
    end
end
