class SessionsController < ApplicationController

  def create
    @user = User.find_by_username(params[:sessions][:username])
    if @user && @user.authenticate(params[:sessions][:password])
      log_in(@user)
      redirect_to spots_path
    else
      render :new
    end
  end

  def destroy
    log_out
    render new_session_path
  end
end
