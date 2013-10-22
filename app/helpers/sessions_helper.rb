module SessionsHelper
  def current_user
    if session[:id] && !(User.all.empty?)
      User.find(session[:id])
    else
      nil
    end
  end

  def log_out
    session[:id] = nil
  end

  def log_in(user)
    session[:id] = user.id
  end

  def signed_in?
    session[:id] != nil
  end
end