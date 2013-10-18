require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "renders log in screen" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "creates a new session" do
      post :create, sessions: {username: new_user.username, password: new_user.password, password_confirmation: new_user.password_confirmation}
      expect(response).to redirect_to spots_path
    end
  end

  describe "DELETE destroy" do
    it "ends the session" do
      post :create, sessions: {username: new_user.username, password: new_user.password, password_confirmation: new_user.password_confirmation}
      delete :destroy
      expect(controller.current_user).to be_nil
    end
  end
end
