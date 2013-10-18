require 'spec_helper'

feature "user can log in" do
  let!(:current_user) {FactoryGirl.create(:user)}
  scenario "when user fills out form to log in correctly should redirect to the spot index page" do
    login(current_user)
    expect(page) == spots_path
  end
end

feature "user can log out" do
  let!(:current_user) {FactoryGirl.create(:user)}
  scenario "when user clicks logout the page should contain 'login'" do
    login(current_user)
    logout
    expect(page).to have_button('Sign In')
  end
end

feature "user chooses a spot" do
  let!(:current_user) {FactoryGirl.create(:user)}
  let!(:test_spot) {FactoryGirl.create(:spot)}
  scenario "spot is no longer visible" do
    deleted_id = test_spot.id
    login(current_user)
    fill_in 'spot[id]', with: deleted_id
    click_button "Choose"
    expect(page).to have_no_content("ID: #{deleted_id}")
  end
end