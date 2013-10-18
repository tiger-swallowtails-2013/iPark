class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(params.require(:user).permit(:username, :password, :email, :password_confirmation))
    if @user.save
      redirect_to spots_path
    else
      render :new
    end
  end
end
