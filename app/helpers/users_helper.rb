module UsersHelper
  def user_notification?
    current_user.notification == true
  end
end