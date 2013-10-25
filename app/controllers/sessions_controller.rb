class SessionsController < ApplicationController

  def create
    p "got here!"
    @user = User.find_by_username(params[:sessions][:username])
    if @user && @user.authenticate(params[:sessions][:password])
      log_in(@user)
      redirect_to spots_path
    else
      redirect_to spots_path
    end
  end

  def destroy
    log_out
    redirect_to spots_path
  end
end