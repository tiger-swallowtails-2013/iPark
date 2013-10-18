require 'spec_helper'

describe UsersController do
  describe "GET signup" do
    it "shows a new user form" do
      expect(get :new).to render_template :new
    end
  end

  describe "POST signup" do
    let(:new_user) { FactoryGirl.build(:user) }
    
    before(:each) do
      User.destroy_all
      @new_spot = FactoryGirl.build(:spot)
    end
    it "creates new user when given valid params" do
      create_user = post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email, password_confirmation: new_user.password_confirmation}
      expect(User.count).to be(1)
    end
    it "renders correct page for new user" do
      expect(post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email, password_confirmation: new_user.password_confirmation}).to redirect_to spots_path
    end
    it "does not create a new user with invalid params" do
      create_user = post :create, :user => {username: new_user.username, password: nil, email: new_user.email}
      expect(User.count).to be(0)
    end
    it "renders correct page for invalid user" do
      expect(post :create, :user => {username: new_user.username, password: nil, email: new_user.email}).to render_template :new
    end
  end

  after(:each) do
    User.destroy_all
  end
end