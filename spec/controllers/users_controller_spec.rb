require 'spec_helper'

describe UsersController do
  describe "GET signup" do
    it "shows a new user form" do
      expect(get :new).to render_template :new
    end
  end

  describe "POST signup" do
    let(:new_user) { FactoryGirl.build(:user) }
    it "creates new user when given valid params" do
      expect(post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email}).to change(User, :count).by(1)
    end
    it "renders correct page for new user" do
      expect(post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email}).to render_template :index
    end
    it "does not create a new user with invalid params" do
      expect(post :create, :user => {username: new_user.username, password: nil, email: new_user.email}).not_to change(User, :count)
    end
    it "renders correct page for invalid user" do
      expect(post :create, :user => {username: new_user.username, password: nil, email: new_user.email}).to render_template :index
    end
  end
end