require 'spec_helper'

module SessionHelper
  def login(user)
    visit spots_path
    fill_in 'sessions[username]', with: user.username
    fill_in 'sessions[password]', with: user.password_confirmation
    click_button "Sign In"
  end

  def logout
    visit "/logout" 
  end
end