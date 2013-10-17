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
      post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email}
      expect(assigns(:user).username).to eq(new_user.username)
      expect(assigns(:user).password).to eq(new_user.password)
      expect(assigns(:user).email).to eq(new_user.email)
    end
    it "renders correct page for new user" do
      expect(post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email}).to render_template :index
    end
    it "does not create a new user with invalid params" do
      post :create, :user => {username: new_user.username, password: nil, email: new_user.email}
      expect(assigns(:user).username).to eq(nil)
      expect(assigns(:user).password).to eq(nil)
      expect(assigns(:user).email).to eq(nil)
    end
    it "renders correct page for invalid user" do
      expect(post :create, :user => {username: new_user.username, password: nil, email: new_user.email}).to render_template :index
    end
  end
end