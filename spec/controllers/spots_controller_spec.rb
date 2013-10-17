require 'spec_helper'

describe SpotsController do
  describe "GET signup" do
    it "shows a new spot form" do
      expect(get :new).to render_template :new
    end
  end

  describe "POST signup" do
    let(:new_spot) { FactoryGirl.build(:spot) }
    it "creates new spot when given valid params" do
      post :create, :spot => {street: new_spot.street, zipcode: new_spot.zipcode, price: new_spot.price, description: new_spot.description, type: new_spot.type}
      expect(assigns(:spot).street).to eq(new_spot.street)
      expect(assigns(:spot).zipcode).to eq(new_spot.zipcode)
      expect(assigns(:spot).email).to eq(new_spot.email)
    end
    it "renders correct page for new spot" do
      expect(post :create, :spot => {spotname: new_spot.spotname, password: new_spot.password, email: new_spot.email}).to render_template :index
    end
    it "does not create a new spot with invalid params" do
      post :create, :spot => {spotname: new_spot.spotname, password: nil, email: new_spot.email}
      expect(assigns(:spot).spotname).to eq(nil)
      expect(assigns(:spot).password).to eq(nil)
      expect(assigns(:spot).email).to eq(nil)
    end
    it "renders correct page for invalid spot" do
      expect(post :create, :spot => {username: new_spot.username, password: nil, email: new_spot.email}).to render_template :index
    end
  end

  describe "GET show" do
  end

  describe "GET index" do
  end

  describe "POSt destroy" do
  end
end
