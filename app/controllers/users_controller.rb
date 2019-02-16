class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        flash[:sucess] = "User created success!"
        redirect_to article_path
      else
        render 'new'
      end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
