require 'spec_helper'

module SessionHelper
  def login(user)
    visit new_session_path
    fill_in 'sessions[username]', with: user.username
    fill_in 'sessions[password]', with: user.password_confirmation
    click_button "Sign In"
  end

  def logout
    visit logout_session_path
  end
end