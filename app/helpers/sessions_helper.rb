module SessionsHelper
  def current_user
    session[:id] ? User.find(session[:id]) : nil
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
