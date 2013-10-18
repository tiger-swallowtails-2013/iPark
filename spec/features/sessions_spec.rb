require 'spec_helper'

feature "user can log in" do
  let!(:current_user) {FactoryGirl.create(:user)}
  scenario "when user fills out form to log in correctly should redirect to the spot index page" do
    visit new_session_path
    fill_in 'sessions[username]', with:
    current_user.username
    fill_in 'sessions[password]', with:
    current_user.password_confirmation
    click_button "Sign In"
    expect(page) == spots_path
  end
end