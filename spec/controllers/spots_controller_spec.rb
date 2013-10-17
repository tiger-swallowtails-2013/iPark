require 'spec_helper'

describe SpotsController do
  describe "GET signup" do
    it "shows a new user form" do
    end
  end

  describe "POST signup" do
    let(:new_spot) { FactoryGirl.build(:spot) }
    it "creates new post when given valid params" do
      post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email}
      expect(assigns(:user).username).to eq(new_user.username)
      expect(assigns(:user).password).to eq(new_user.password)
      expect(assigns(:user).email).to eq(new_user.email)
    end
    it "renders correct page for new spot" do
      expect(post :create, :user => {username: new_user.username, password: new_user.password, email: new_user.email}).to render_template :index
    end
    it "does not create a new spot with invalid params" do
      post :create, :user => {username: new_user.username, password: nil, email: new_user.email}
      expect(assigns(:user).username).to eq(nil)
      expect(assigns(:user).password).to eq(nil)
      expect(assigns(:user).email).to eq(nil)
    end
    it "renders correct page for invalid spot" do
      expect(post :create, :user => {username: new_user.username, password: nil, email: new_user.email}).to render_template :index
    end
  end

  describe "GET show" do
  end

  describe "GET index" do
  end

  describe "POSt destroy" do
  end
end
