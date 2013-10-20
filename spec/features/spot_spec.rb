# require 'spec_helper'

# feature "user can create new spot" do
#   let!(:current_user) {FactoryGirl.create(:user)}
#   scenario "a logged in user can successfully create new spots" do
#     login(current_user)
#     click_link("List a Spot")
#     fill_in('spot_street', :with => "717 California St.")
#     fill_in('Zip co', :with => 94108)
#     fill_in('Price', :with => 50)
#     fill_in("Location type", :with =>)
#   end
# end

# feature "user can reserve a spot" do
#   let!(:current_user) {FactoryGirl.create(:user)}
#   scenario "when user clicks logout the page should contain 'login'" do
#     login(current_user)
#     logout
#     expect(page).to have_button('Sign In')
#   end
# end

# feature "user can choose a spot" do
#   let!(:current_user) {FactoryGirl.create(:user)}
#   let!(:test_spot) {FactoryGirl.create(:spot)}
#   scenario "spot is no longer visible" do
#     deleted_id = test_spot.id
#     login(current_user)
#     fill_in 'spot[id]', with: deleted_id
#     click_button "Choose"
#     expect(page).to have_no_content("ID: #{deleted_id}")
#   end
# end

#     fill_in('First Name', :with => 'John')
#     fill_in('Password', :with => 'Seekrit')
#     fill_in('Description', :with => 'Really Long Text…')
#     choose('A Radio Button')
#     check('A Checkbox')
#     uncheck('A Checkbox')
#     attach_file('Image', '/path/to/image.jpg')
#     select('Option', :from => 'Select Box')